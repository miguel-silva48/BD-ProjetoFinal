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
        private String _nomeGerente;
        private String _numFunc;

        public String Codigo
        {
            get { return _codigo; }
            set
            {
                if (value == null | String.IsNullOrEmpty(value))
                {
                    throw new Exception("ERRO: O campo Codigo nao pode estar vazio!");
                }
                _codigo = value;
            }
        }

        public String Designacao
        {
            get { return _designacao; }
            set
            {
                if (value == null | String.IsNullOrEmpty(value))
                {
                    throw new Exception("ERRO: O campo Designaçao nao pode estar vazio!");
                }
                _designacao = value;
            }
        }  

        public String NomeGerente
        {
            get { return _nomeGerente; }
            set
            {
                _nomeGerente = value;
            }
        }

        public String NumFunc
        {
            get { return _numFunc; }
            set
            {
                _numFunc = value;
            }
        }

        public override String ToString()
        {
            return String.Format("{0}. {1}", _codigo, _designacao); 
        }
    }
}