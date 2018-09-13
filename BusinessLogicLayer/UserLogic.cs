using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using DataAccessLayer.Archive_SystemTableAdapters;

namespace BusinessLogicLayer
{
    public class UserLogic
    {
        private UsersTableAdapter _usersTableAdapter;

        private UsersTableAdapter Adapter => _usersTableAdapter ?? (_usersTableAdapter = new UsersTableAdapter());

        public bool UpdateName(string firstName, string middleName, string lastName, Guid userId)
        {
            var rowsAffected = Adapter.UpdateName(firstName.ToUpper(), middleName.ToUpper(), lastName.ToUpper(), userId);
            return rowsAffected == 1;
        }
    }
}
