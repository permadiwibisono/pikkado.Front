using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Front.Areas.Admin.Models
{
    public class PostalCodeViewModel
    {
        public PostalCodeViewModel()
        {
            Cities = new List<City>();
            Cities.Add(new City { CityName = "Pilih kota" });
            Cities.Add(new City { CityName = "Jakarta Selatan" });
            Cities.Add(new City { CityName = "Jakarta Timur" });
            Kecamatans = new List<Kecamatan>();
            Kecamatans.Add(new Kecamatan { CityName = "", KecamatanName = "Pilih kecamatan" });
            Kecamatans.Add(new Kecamatan { CityName = "Jakarta Selatan", KecamatanName = "Cilandak" });
            Kecamatans.Add(new Kecamatan { CityName = "Jakarta Selatan", KecamatanName = "Jagakarsa" });
            Kecamatans.Add(new Kecamatan { CityName = "Jakarta Selatan", KecamatanName = "Kebayoran Lama" });
            Kecamatans.Add(new Kecamatan { CityName = "Jakarta Timur", KecamatanName = "Cakung" });
            Kecamatans.Add(new Kecamatan { CityName = "Jakarta Timur", KecamatanName = "Cipayung" });
            Kelurahans = new List<Kelurahan>();
            Kelurahans.Add(new Kelurahan { KecamatanName = "", KelurahanName = "Pilih kelurahan" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Cilandak", KelurahanName = "Cipete Selatan" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Cilandak", KelurahanName = "Gandaria Selatan" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Cilandak", KelurahanName = "Cilandak Barat" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Cilandak", KelurahanName = "Lebak Bulus" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Cilandak", KelurahanName = "Pondok Labu" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Jagakarsa", KelurahanName = "Tanjung Barat" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Jagakarsa", KelurahanName = "Lenteng Agung" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Jagakarsa", KelurahanName = "Jagakarsa" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Cakung", KelurahanName = "Cakung Barat" });
            Kelurahans.Add(new Kelurahan { KecamatanName = "Cakung", KelurahanName = "Cakung Timur" });
        }
        public List<City> Cities { get; set; }
        public List<Kelurahan> Kelurahans { get; set; }
        public List<Kecamatan> Kecamatans { get; set; }
        public string CitySelected { get; set; }
        public string KelSelected { get; set; }
        public string KecSelected { get; set; }
    }
    public class City
    {
        public string CityName { get; set; }
    }
    public class Kelurahan
    {
        public string KecamatanName { get; set; }
        public string KelurahanName { get; set; }
    }
    public class Kecamatan
    {
        public string CityName { get; set; }
        public string KecamatanName { get; set; }
    }
}
