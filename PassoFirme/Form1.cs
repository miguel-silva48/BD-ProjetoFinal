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
        private int currentValue;
        private bool adding;

        public Form1()
        {
            InitializeComponent();
            this.Text = "Passo Firme";
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            cn = getSGBDConnection();
            loadProdutos(sender, e);
        }

        //SQL connection stuff
        private SqlConnection getSGBDConnection()
        {
            return new SqlConnection("data source=HP-ENVY14\\SQLEXPRESS;integrated security=true;initial catalog=Northwind");
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
        
        
        //Load stuff
        private void  loadProdutos(object sender, EventArgs e)
        {
            if (!verifySGBDConnection())
                return;

            SqlCommand cmd = new SqlCommand("SELECT * FROM Empresa.Produto JOIN Empresa.TipoProduto ON Produto.categoria_tipo = TipoProduto.categoria;", cn);
            SqlDataReader reader = cmd.ExecuteReader();
            listBox_produtos.Items.Clear();

                        while (reader.Read())
            {
                Produto P = new Produto();
                P.Codigo = reader["codigo"].ToString();
                listBox_produtos.Items.Add(P);
            }

            cn.Close();
        }
















        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void label_email_Click(object sender, EventArgs e)
        {

        }

        private void label_morada_Click(object sender, EventArgs e)
        {

        }

        private void label_nif_Click(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox_nif_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox_nome_TextChanged(object sender, EventArgs e)
        {

        }

        private void label_revendedor_Click(object sender, EventArgs e)
        {

        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox8_TextChanged(object sender, EventArgs e)
        {

        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void label9_Click(object sender, EventArgs e)
        {

        }

        private void listBox4_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
