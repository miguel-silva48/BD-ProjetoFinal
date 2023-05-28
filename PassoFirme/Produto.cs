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
        private String _codigo;
        private String _categoria;
        private String _custoFabrico;
        private String _precoVenda;
        private String _numEncomenda;
        private String _quantidadeArmazem;

    public String Codigo
    {
        get { return _codigo; }
        set
        {
            if (value == null | String.IsNullOrEmpty(value))
            {
                throw new Exception("ERRO: O campo Código não pode estar vazio!");
            }
            _codigo = value;
        }
    }

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

    public String NumEncomenda
    {
        get { return _numEncomenda; }
        set { _numEncomenda = value; }
    }

    public String QuantidadeArmazem
    {
        get { return _quantidadeArmazem; }
        set { _quantidadeArmazem = value; }
    }

    }
}