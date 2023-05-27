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
                P.CodigoMateriaPrima = reader["codigo_materia_prima"].ToString();
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
            textBox_codMatPrima_produto.Text = prod.CodigoMateriaPrima;
        }

        private void listBox_produtos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBox_produtos.SelectedIndex >= 0)
            {
                currentProduto = listBox_produtos.SelectedIndex;
                ShowProduto();
            }
        }
//End of Produto Stuff


//Funcionario Stuff
        private void loadFuncionarios(object sender, EventArgs e)
        {
            if (!verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM Empresa.Funcionario;", cn);
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
                //F.Seccao = reader["seccao"].ToString();
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
            //textBox_seccao_funcionario.Text = func.Seccao;
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
            textBox_nome_revendedor.Text = rev.Nome;
            textBox_nif_revendedor.Text = rev.Nif;
            textBox_morada_revendedor.Text = rev.Morada;
            textBox_email_revendedor.Text = rev.Email;
        }

        private void listBox_revendedor_SelectedIndexChanged_1(object sender, EventArgs e)
        {
            if (listBox_revendedor.SelectedIndex >= 0)
            {
                currentRevendedor = listBox_revendedor.SelectedIndex;
                ShowRevendedor();
            }
        }
//End of Revendedor Stuff


        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
