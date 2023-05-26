using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;

namespace PassoFirme
{

    [Serializable()]

    public class Fornecedor
    {
        private String _nif;
        private String _nome;
        private String _morada;
        private String _email;

        public String Nif
        {
            get { return _nif; }
            set
            {
                if (value == null | String.IsNullOrEmpty(value))
                {
                    throw new Exception("ERROR: O campo NIF não pode estar vazio!");
                }
                _nif = value;
            }
        }

        public String Nome
        {
            get { return _nome; }
            set { _nome = value; }
        }

        public String Morada
        {
            get { return _morada; }
            set { _morada = value; }
        }

        public String Email
        {
            get { return _email; }
            set { _email = value; }
        }

    }
}
