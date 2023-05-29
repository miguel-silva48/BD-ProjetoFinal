using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;

namespace PassoFirme
{

    [Serializable()]

    public class Funcionario
    {
        private String _id;
        private String _nome;
        private String _nif;
        private String _numCC;
        private String _morada;
        private String _salario;
        private String _seccao;
        private String _serGerente;

        public String Id
        {
            get { return _id; }
            set
            {
                if (value == null | String.IsNullOrEmpty(value))
                {
                    throw new Exception("ERROR: O campo ID não pode estar vazio!");
                }
                _id = value;
            }
        }

        public String Nome
        {
            get { return _nome; }
            set { _nome = value; }
        }

        public String Nif
        {
            get { return _nif; }
            set { _nif = value; }
        }

        public String NumCC
        {
            get { return _numCC; }
            set { _numCC = value; }
        }

        public String Morada
        {
            get { return _morada; }
            set { _morada = value; }
        }

        public String Salario
        {
            get { return _salario; }
            set { _salario = value; }
        }

        public String Seccao
        {
            get { return _seccao; }
            set { _seccao = value; }
        }

        public String SerGerente
        {
            get { return _serGerente; }
            set { _serGerente = value; }
        }

        public override String ToString()
        {
            return String.Format("{0} - {1}", _id, _nome);
        }
    }
}
