using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;

namespace PassoFirme
{

    [Serializable()]

    public class Produto
    {
        private String _categoria;
        private String _custoFabrico;
        private String _precoVenda;
        private String _numProdutos;
        private String _numEncomendas;

    public String Categoria
    {
        get { return _categoria; }
        set { _categoria = value; }
    }

    public String CustoFabrico
    {
        get { return _custoFabrico; }
        set { _custoFabrico = value; }
    }

    public String PrecoVenda
    {
        get { return _precoVenda; }
        set { _precoVenda = value; }
    }

    public String NumEncomendas
    {
        get { return _numEncomendas; }
        set { _numEncomendas = value; }
    }

    public String NumProdutos
    {
        get { return _numProdutos; }
        set { _numProdutos = value; }
    }

    public override String ToString()
    {
        return String.Format("{0}",  _categoria); 
    }

    }
}