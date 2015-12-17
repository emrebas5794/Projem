using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CalismaBLL
{
    interface IRepository<T>
    {
        int Insert(T item);
        int Delete(int id);
        int Update(T item);
        List<T> GetAll();
        T GetById(int id);
    }
}
