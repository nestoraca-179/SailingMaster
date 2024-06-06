using SailingMaster.Models;
using System;
using System.Linq;

namespace SailingMaster.Controllers
{
    public class MonedaController : Repository
    {
        public static Moneda GetByID(string id)
        {
            return db.Moneda.Single(m => m.ID == id);
        }

        public static decimal ConvertToBSD(Servicio serv)
        {
            decimal final = 0, tasa_usd = GetByID("USD").tasa, tasa_eur = GetByID("EUR").tasa;
            decimal tasa_eurusd = Math.Round(tasa_eur / tasa_usd, 2);

            if (serv.co_mone == "USD")
                final = serv.precio_base * tasa_usd;
            else if (serv.co_mone == "EUR")
                final = Math.Round((serv.precio_base * tasa_eurusd) * tasa_usd, 2);

            return final;
        }

        public static decimal ConvertToUSD(Servicio serv)
        {
            decimal final = 0, tasa_usd = GetByID("USD").tasa, tasa_eur = GetByID("EUR").tasa;
            decimal tasa_eurusd = Math.Round(tasa_eur / tasa_usd, 2);

            if (serv.co_mone == "BSD")
                final = Math.Round(serv.precio_base / tasa_usd, 2);
            else if (serv.co_mone == "EUR")
                final = serv.precio_base * tasa_eurusd;

            return final;
        }

        public static decimal ConvertToEUR(Servicio serv)
        {
            decimal final = 0, tasa_usd = GetByID("USD").tasa, tasa_eur = GetByID("EUR").tasa;
            decimal tasa_eurusd = Math.Round(tasa_eur / tasa_usd, 2);

            if (serv.co_mone == "BSD")
                final = Math.Round((serv.precio_base / tasa_usd) / tasa_eurusd, 2);
            else if (serv.co_mone == "USD")
                final = Math.Round(serv.precio_base / tasa_eurusd, 2);

            return final;
        }
    }
}