using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pickkado.Front.Areas.Admin.Models
{
    public class MasterCategoryViewModel
    {
        [Required]
        [Display(Name = "Category Name :")]
        public string Name { get; set; }
        [Required]
        [Display(Name = "Image Url :")]
        public string ImageUrl { get; set; }
        [Display(Name = "Visible :")]
        public bool Visible { get; set; }
    }
    public class MasterCategoryViewModel1
    {
        [Required]
        [Display(Name = "Category Name :")]
        public string Name { get; set; }
        [Required]
        [Display(Name = "Image Url :")]
        public string ImageUrl { get; set; }
        [Display(Name = "Visible :")]
        public bool Visible { get; set; }
    }
    public class CategoryModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<CategoryModel> Child { get; set; }
        public string Parent { get; set; }
        public int Level { get; set; }
        public int Left { get; set; }
        public int Right { get; set; }
    }
}
