using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;

namespace PassoFirme
{

    [Serializable()]

    public class Seccao
    {
        private String _codigo;
        private String _designacao;

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

        public String Designacao
        {
            get { return _designacao; }
            set { _designacao = value; }
        }

    }
}