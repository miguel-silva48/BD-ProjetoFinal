using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace PassoFirme
{
    public partial class Form1 : Form
    {
        private SqlConnection cn;
        private int currentProduto;
        private int currentFuncionario;
        private int currentFornecedor;
        private int currentRevendedor;
        private int currentSeccao;
        //private bool adding;

        public Form1()
        {
            InitializeComponent();
            this.Text = "Passo Firme";
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            cn = getSGBDConnection();
            loadProdutos(sender, e);
            loadFuncionarios(sender, e);
            loadFornecedor(sender, e);
            loadRevendedor(sender, e);
            loadSeccao(sender, e);
        }

//SQL connection stuff
        private SqlConnection getSGBDConnection()
        {
            return new SqlConnection("data source=tcp:mednat.ieeta.pt\\SQLSERVER,8101; Initial Catalog = p5g5; uid = p5g5; password = bd_2023");
        }

        private bool verifySGBDConnection()
        {
            if (cn == null)
                cn = getSGBDConnection();

            if (cn.State != ConnectionState.Open)
                cn.Open();

            return cn.State == ConnectionState.Open;
        }
//End of SQL connection stuff
        
        
//Produto Stuff
        private void loadProdutos(object sender, EventArgs e)
        {
            if (!verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM Empresa.Produto JOIN Empresa.TipoProduto ON Produto.categoria_tipo = TipoProduto.categoria;", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBox_produtos.Items.Clear();

            while (reader.Read())
            {
                Produto P = new Produto();
                P.Codigo = reader["codigo_produto"].ToString();
                P.Categoria = reader["categoria"].ToString();
                P.CustoFabrico = reader["custo_fabrico"].ToString();
                P.PrecoVenda = reader["preco_venda"].ToString();
                P.NumEncomenda = reader["num_encomenda"].ToString();
                //P.QuantidadeArmazem = reader["quantidade_armazem"].ToString();
                listBox_produtos.Items.Add(P);
            }

            cn.Close();

            currentProduto = 0;
            ShowProduto();
        }

        private void ShowProduto()
        {
            if (listBox_produtos.Items.Count == 0 | currentProduto < 0)
                return;
            Produto prod = new Produto();
            prod = (Produto)listBox_produtos.Items[currentProduto];
            textBox_categoria_produto.Text = prod.Categoria;
            textBox_codigo_produto.Text = prod.Codigo;
            textBox_custo_produto.Text = prod.CustoFabrico;
            textBox_preco_produto.Text = prod.PrecoVenda;
            textBox_numEncomenda_produto.Text = prod.NumEncomenda;
            //textBox_quantidade_produto.Text = prod.QuantidadeArmazem;
        }

        private void listBox_produtos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBox_produtos.SelectedIndex >= 0)
            {
                currentProduto = listBox_produtos.SelectedIndex;
                ShowProduto();
            }
        }

//TODO criar as caixas de texto no design e testar
        private void removeProduto(String codigo_produto)
        {
            if (!verifySGBDConnection())
                return;
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "DELETE Empresa.Produto WHERE codigo_produto=@codigo_produto";
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@codigo_produto", codigo_produto);
            cmd.Connection = cn;

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("ERRO: Nao foi possivel apagar o produto na BD! \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }
//End of Produto Stuff


//Funcionario Stuff
        private void loadFuncionarios(object sender, EventArgs e)
        {
            if (!verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM (Empresa.Gerente JOIN Empresa.Funcionario ON ID_Funcionario=ID) JOIN Empresa.Seccao ON codigo_seccao=codigo;", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBox_funcionarios.Items.Clear();

            while (reader.Read())
            {
                Funcionario F = new Funcionario();
                F.Nif = reader["nif"].ToString();
                F.Nome = reader["nome"].ToString();
                F.NumCC = reader["numerocc"].ToString();
                F.Morada = reader["morada"].ToString();
                F.Id = reader["ID"].ToString();
                F.Salario = reader["salario"].ToString();
                F.Seccao = reader["designacao"].ToString();
                F.SerGerente = "Sim";
                listBox_funcionarios.Items.Add(F);
            }

            reader.Close();

            SqlCommand cmd2 = new SqlCommand("SELECT * FROM (Empresa.Operario JOIN  Empresa.Seccao ON codigo_seccao=codigo) JOIN Empresa.Funcionario ON ID_Funcionario=ID WHERE Operario.ID_funcionario NOT IN (SELECT Gerente.ID_funcionario FROM Empresa.Gerente);", cn);
            reader = cmd2.ExecuteReader();

            while (reader.Read())
            {
                Funcionario F = new Funcionario();
                F.Nif = reader["nif"].ToString();
                F.Nome = reader["nome"].ToString();
                F.NumCC = reader["numerocc"].ToString();
                F.Morada = reader["morada"].ToString();
                F.Id = reader["ID"].ToString();
                F.Salario = reader["salario"].ToString();
                F.Seccao = reader["designacao"].ToString();
                F.SerGerente = "Não";
                listBox_funcionarios.Items.Add(F);
            }

            cn.Close();

            currentFuncionario = 0;
            ShowFuncionario();
        }

        private void ShowFuncionario()
        {
            if (listBox_funcionarios.Items.Count == 0 | currentFuncionario < 0)
                return;
            Funcionario func = new Funcionario();
            func = (Funcionario)listBox_funcionarios.Items[currentFuncionario];
            textBox_nome_funcionario.Text = func.Nome;
            textBox_nif_funcionario.Text = func.Nif;
            textBox_numCC_funcionario.Text = func.NumCC;
            textBox_morada_funcionario.Text = func.Morada;
            textBox_id_funcionario.Text = func.Id;
            textBox_salario_funcionario.Text = func.Salario;
            textBox_seccao_funcionario.Text = func.Seccao;
            textBox_gerente_funcionario.Text = func.SerGerente;
        }

        private void listBox_funcionarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBox_funcionarios.SelectedIndex >= 0)
            {
                currentFuncionario = listBox_funcionarios.SelectedIndex;
                ShowFuncionario();
            }
        }

//TODO: criar as caixas de texto no design e testar
        private void removeFuncionario(String id_funcionario)
        {
            if (!verifySGBDConnection())
                return;
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "DELETE Empresa.Funcionario WHERE ID=@id_funcionario";
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@id_funcionario", id_funcionario);
            cmd.Connection = cn;

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("ERRO: Nao foi possivel apagar o funcionario na BD! \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }
//End of Funcionario Stuff


//Fornecedor Stuff
        private void loadFornecedor(object sender, EventArgs e)
        {
            if (!verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM Empresa.Fornecedor;", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBox_fornecedor.Items.Clear();

            while (reader.Read())
            {
                Fornecedor F = new Fornecedor();
                F.Nif = reader["nif"].ToString();
                F.Nome = reader["nome"].ToString();
                F.Morada = reader["morada"].ToString();
                F.Email = reader["email"].ToString();
                listBox_fornecedor.Items.Add(F);
            }

            cn.Close();

            currentFornecedor = 0;
            ShowFornecedor();
        }

        private void ShowFornecedor()
        {
            if (listBox_fornecedor.Items.Count == 0 | currentFornecedor < 0)
                return;
            Fornecedor forn = new Fornecedor();
            forn = (Fornecedor)listBox_fornecedor.Items[currentFornecedor];
            textBox_nome_fornecedor.Text = forn.Nome;
            textBox_nif_fornecedor.Text = forn.Nif;
            textBox_morada_fornecedor.Text = forn.Morada;
            textBox_email_fornecedor.Text = forn.Email;
        }

        private void listBox_fornecedor_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBox_fornecedor.SelectedIndex >= 0)
            {
                currentFornecedor = listBox_fornecedor.SelectedIndex;
                ShowFornecedor();
            }
        }

//TODO: criar as caixas de texto no design e testar
        private void removeFornecedor(String nif_fornecedor)
        {
            if (!verifySGBDConnection())
                return;
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "DELETE Empresa.Fornecedor WHERE nif=@nif_fornecedor";
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@nif_fornecedor", nif_fornecedor);
            cmd.Connection = cn;

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("ERRO: Nao foi possivel apagar o Fornecedor na BD! \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }

//End of Fornecedor Stuff


//Revendedor Stuff
        private void loadRevendedor(object sender, EventArgs e)
        {
            if (!verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM Empresa.Revendedor;", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBox_revendedor.Items.Clear();

            while (reader.Read())
            {
                Revendedor R = new Revendedor();
                R.Nif = reader["nif"].ToString();
                R.Nome = reader["nome"].ToString();
                R.Morada = reader["morada"].ToString();
                R.Email = reader["email"].ToString();
                listBox_revendedor.Items.Add(R);
            }

            cn.Close();

            currentRevendedor = 0;
            ShowRevendedor();
        }

        public void ShowRevendedor()
        {
            if (listBox_revendedor.Items.Count == 0 | currentRevendedor < 0)
                return;
            Revendedor rev = new Revendedor();
            rev = (Revendedor)listBox_revendedor.Items[currentRevendedor];

            String numEncomendas;
            String numProdutosEncomendados;

            cn.Open();

            using (SqlCommand cmd2 = new SqlCommand("getEncomendasRevendedor", cn))
            {
                cmd2.CommandType = CommandType.StoredProcedure;

                cmd2.Parameters.Add("@nif", SqlDbType.Int).Value = rev.Nif;

                cmd2.Parameters.Add("@num", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd2.Parameters.Add("@quantidade", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd2.ExecuteNonQuery();

                numEncomendas = Convert.ToString(cmd2.Parameters["@num"].Value);
                numProdutosEncomendados = Convert.ToString(cmd2.Parameters["@quantidade"].Value);
            }

            cn.Close();

            textBox_nome_revendedor.Text = rev.Nome;
            textBox_nif_revendedor.Text = rev.Nif;
            textBox_morada_revendedor.Text = rev.Morada;
            textBox_email_revendedor.Text = rev.Email;
            //TODO criar as caixas de texto no design
            //textBox_numEncomendas_revendedor.Text = numEncomendas;
            //textBox_numProdutosEncomendados_revendedor.Text = numProdutosEncomendados;
        }

        private void listBox_revendedor_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            if (listBox_revendedor.SelectedIndex >= 0)
            {
                currentRevendedor = listBox_revendedor.SelectedIndex;
                ShowRevendedor();
            }
        }

//TODO: criar as caixas de texto no design e testar
//Operações de edição e remoção de revendedores

        private void button_apagar_revendedor_Click(object sender, EventArgs e)
        {

        }

        private void button_editar_revendedor_Click(object sender, EventArgs e)
        {

        }
        
        private void removeRevendedor (String nif_revendedor)
        {
            if (!verifySGBDConnection())
                return;
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "DELETE Empresa.Revendedor WHERE nif=@nif_revendedor";
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@nif_revendedor", nif_revendedor);
            cmd.Connection = cn;

            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw new Exception("ERRO: Nao foi possivel apagar o Revendedor na BD! \n ERROR MESSAGE: \n" + ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }
//End of Revendedor Stuff

//Seccao Stuff
        private void loadSeccao(object sender, EventArgs e)
        {
            if (!verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM Empresa.Seccao;", cn);
            SqlDataReader reader = cmd.ExecuteReader();

            listBox_seccao.Items.Clear();

            while (reader.Read())
            {
                Seccao S = new Seccao();
                S.Codigo = reader["codigo"].ToString();
                S.Designacao = reader["designacao"].ToString();
                listBox_seccao.Items.Add(S);
            }

            cn.Close();

            currentSeccao = 0;
            ShowSeccao();
        }

        private void ShowSeccao()
        {
            if (listBox_seccao.Items.Count == 0 | currentSeccao < 0)
                return;
            Seccao seccao = new Seccao();
            seccao = (Seccao)listBox_seccao.Items[currentSeccao];

            String numEmEspera;
            String numEmProducao;
            String numConcluido;

            cn.Open();

            using (SqlCommand cmd2 = new SqlCommand("getNumEstadoBySeccao", cn))
            {
                cmd2.CommandType = CommandType.StoredProcedure;

                cmd2.Parameters.Add("@codigo", SqlDbType.Int).Value = seccao.Codigo;

                cmd2.Parameters.Add("@numEmEspera", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd2.Parameters.Add("@numEmProducao", SqlDbType.Int).Direction = ParameterDirection.Output;
                cmd2.Parameters.Add("@numConcluido", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd2.ExecuteNonQuery();

                numEmEspera = Convert.ToString(cmd2.Parameters["@numEmEspera"].Value);
                numEmProducao = Convert.ToString(cmd2.Parameters["@numEmProducao"].Value);
                numConcluido = Convert.ToString(cmd2.Parameters["@numConcluido"].Value);
            }

            cn.Close();

            textBox_designacao_seccao.Text = seccao.Designacao;
            textBox_codigo_seccao.Text = seccao.Codigo;
            textBox_emEspera.Text = numEmEspera;
            textBox_emProducao.Text = numEmProducao;
            textBox_concluido.Text = numConcluido;
        }


        private void listBox_seccao_SelectedIndexChanged(object sender, EventArgs e)
        {
                if (listBox_seccao.SelectedIndex >= 0)
                {
                    currentSeccao = listBox_seccao.SelectedIndex;
                    ShowSeccao();
                }
        }
//End of Seccao Stuff


        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button2_Click(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {

        }

    }
}
