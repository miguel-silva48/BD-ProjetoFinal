using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PassoFirme
{
    class Processo
    {
        private String _ID_funcionario, _codigo_produto, _codigo_materia_prima, _estado;



        public String IDFuncionario
        {
            get { return _ID_funcionario; }
            set
            {
                _ID_funcionario = value;
            }
        }

        public String CodProduto
        {
            get { return _codigo_produto; }
            set
            {
                _codigo_produto = value;
            }
        }

        public String CodMatPrima
        {
            get { return _codigo_materia_prima; }
            set
            {
                _codigo_materia_prima = value;
            }
        }

        public String Estado
        {
            get { return _estado; }
            set
            {
                _estado = value;
            }
        }

        public override String ToString()
        {
            return String.Format("{0}               {1}             {2}             {3}", _ID_funcionario, _codigo_produto, _codigo_materia_prima, _estado);
        }
    }
}
