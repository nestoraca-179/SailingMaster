using SailingMaster.Models;

namespace SailingMaster.Controllers
{
    public abstract class Repository
    {
        public readonly static SailingMasterEntities db = new SailingMasterEntities();
    }
}