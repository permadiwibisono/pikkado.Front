namespace pickkado.Front.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class InitialCreate : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Brands",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Products",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        BrandId = c.String(maxLength: 128),
                        StoreId = c.String(maxLength: 128),
                        Name = c.String(),
                        Weight = c.Single(nullable: false),
                        Description = c.String(),
                        Gender = c.String(),
                        Price = c.Single(nullable: false),
                        Categories = c.Int(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Brands", t => t.BrandId)
                .ForeignKey("dbo.Stores", t => t.StoreId)
                .Index(t => t.BrandId)
                .Index(t => t.StoreId);
            
            CreateTable(
                "dbo.ProductAttributes",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        MasterProductAttributeId = c.String(maxLength: 128),
                        ProductId = c.String(maxLength: 128),
                        Value = c.String(),
                        Disabled = c.Boolean(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.MasterProductAttributes", t => t.MasterProductAttributeId)
                .ForeignKey("dbo.Products", t => t.ProductId)
                .Index(t => t.MasterProductAttributeId)
                .Index(t => t.ProductId);
            
            CreateTable(
                "dbo.MasterProductAttributes",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Stores",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(),
                        Address = c.String(),
                        Kelurahan = c.String(),
                        Kecamatan = c.String(),
                        Kota = c.String(),
                        PhoneNumber = c.String(),
                        WebAddress = c.String(),
                        Email = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.ProductStores",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        StoreId = c.String(maxLength: 128),
                        ProductId = c.String(maxLength: 128),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Products", t => t.ProductId)
                .ForeignKey("dbo.Stores", t => t.StoreId)
                .Index(t => t.StoreId)
                .Index(t => t.ProductId);
            
            CreateTable(
                "dbo.ProductThumbnails",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        ProductId = c.String(maxLength: 128),
                        Image = c.Binary(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Products", t => t.ProductId)
                .Index(t => t.ProductId);
            
            CreateTable(
                "dbo.Categories",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        ImageUrl = c.String(),
                        Visible = c.Boolean(nullable: false),
                        Left = c.Int(nullable: false),
                        Right = c.Int(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Destinations",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        DestinationName = c.String(),
                        UserId = c.String(maxLength: 128),
                        Address = c.String(),
                        Kelurahan = c.String(),
                        Kecamatan = c.String(),
                        Kota = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Users", t => t.UserId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.Users",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        FirstName = c.String(),
                        LastName = c.String(),
                        BirthDate = c.DateTime(nullable: false),
                        BirthPlace = c.String(),
                        Email = c.String(),
                        Gender = c.Byte(nullable: false),
                        PhoneNumber = c.String(),
                        VirtualMoney = c.Single(nullable: false),
                        Image = c.Binary(),
                        UserType = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.NoRekenings",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        UserId = c.String(maxLength: 128),
                        AtasNama = c.String(),
                        NomorRekening = c.String(),
                        Bank = c.String(),
                        CabangBank = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Users", t => t.UserId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.Notifications",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        UserId = c.String(maxLength: 128),
                        Type = c.String(),
                        SenderId = c.String(),
                        SenderName = c.String(),
                        Description = c.String(),
                        Thumbnail = c.Binary(),
                        Link = c.String(),
                        NotificationDate = c.DateTime(nullable: false),
                        Title = c.String(),
                        IsDistributed = c.Boolean(nullable: false),
                        IsSeen = c.Boolean(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Users", t => t.UserId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.Reminders",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        UserId = c.String(maxLength: 128),
                        EventName = c.String(),
                        EventDate = c.DateTime(nullable: false),
                        Content = c.String(),
                        RemindMe = c.DateTime(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Users", t => t.UserId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.Transactions",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        TransDate = c.DateTime(nullable: false),
                        TanggalKirim = c.DateTime(nullable: false),
                        TransactionType = c.String(),
                        UserId = c.String(maxLength: 128),
                        UserName = c.String(),
                        IsGroup = c.Boolean(nullable: false),
                        GroupCount = c.Int(nullable: false),
                        GroupTitle = c.String(),
                        GroupDescription = c.String(),
                        GroupReceiverName = c.String(),
                        ProductId = c.String(maxLength: 128),
                        ProductImage = c.Binary(),
                        ProductName = c.String(),
                        ProductBrand = c.String(),
                        ProductCategory = c.String(),
                        ProductWeight = c.Single(nullable: false),
                        ProductDescription = c.String(),
                        PackageId = c.String(maxLength: 128),
                        PackageImage = c.Binary(),
                        PackageName = c.String(),
                        PackagePrice = c.Single(nullable: false),
                        GreetingCardId = c.String(),
                        GreetingCardImage = c.Binary(),
                        GreetingCardName = c.String(),
                        GreetingCardPrice = c.Single(nullable: false),
                        InviteFriendGiftcardMessage = c.String(),
                        ReceiveName = c.String(),
                        StoreId = c.String(maxLength: 128),
                        StoreName = c.String(),
                        StoreAddress = c.String(),
                        StorePhoneNumber = c.String(),
                        DestinationAddress = c.String(),
                        City = c.String(),
                        Kecamatan = c.String(),
                        Kelurahan = c.String(),
                        Status = c.String(),
                        ProductPrice = c.Single(nullable: false),
                        ShippingFee = c.Single(nullable: false),
                        ServiceFee = c.Single(nullable: false),
                        VoucherId = c.String(),
                        DiscountVoucherPrice = c.Single(nullable: false),
                        NamaKurir = c.String(),
                        JenisPaket = c.String(),
                        AsuransiKurir = c.String(),
                        ResiNumber = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Packages", t => t.PackageId)
                .ForeignKey("dbo.Products", t => t.ProductId)
                .ForeignKey("dbo.Stores", t => t.StoreId)
                .ForeignKey("dbo.Users", t => t.UserId)
                .Index(t => t.UserId)
                .Index(t => t.ProductId)
                .Index(t => t.PackageId)
                .Index(t => t.StoreId);
            
            CreateTable(
                "dbo.Packages",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(),
                        Image = c.Binary(),
                        Price = c.Single(nullable: false),
                        Quantity = c.Int(nullable: false),
                        Visible = c.Boolean(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.TransactionGiftcardMessages",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        TransactionId = c.String(maxLength: 128),
                        UserId = c.String(maxLength: 128),
                        Email = c.String(),
                        Name = c.String(),
                        Message = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Transactions", t => t.TransactionId)
                .ForeignKey("dbo.Users", t => t.UserId)
                .Index(t => t.TransactionId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.TransactionMemberGroups",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        TransactionId = c.String(maxLength: 128),
                        UserId = c.String(maxLength: 128),
                        Email = c.String(),
                        Name = c.String(),
                        Price = c.Single(nullable: false),
                        IsAccept = c.Boolean(nullable: false),
                        IsResponse = c.Boolean(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Transactions", t => t.TransactionId)
                .ForeignKey("dbo.Users", t => t.UserId)
                .Index(t => t.TransactionId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.TransactionPayments",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        TransactionId = c.String(maxLength: 128),
                        UserId = c.String(maxLength: 128),
                        TanggalPembayaran = c.DateTime(nullable: false),
                        PaymentType = c.String(),
                        NoRekening = c.String(),
                        NamaRekening = c.String(),
                        NamaBank = c.String(),
                        CabangBank = c.String(),
                        NoStrukPembayaran = c.String(),
                        StatusPembayaran = c.String(),
                        NoRekeningTujuan = c.String(),
                        NamaRekeningTujuan = c.String(),
                        NamaBankTujuan = c.String(),
                        CabangBankTujuan = c.String(),
                        TotalDiBayar = c.Double(nullable: false),
                        Remarks = c.String(),
                        BuktiPembayaran = c.Binary(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Transactions", t => t.TransactionId)
                .ForeignKey("dbo.Users", t => t.UserId)
                .Index(t => t.TransactionId)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.TransactionProductAttributes",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        TransactionId = c.String(maxLength: 128),
                        ProductId = c.String(maxLength: 128),
                        Name = c.String(),
                        Value = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Products", t => t.ProductId)
                .ForeignKey("dbo.Transactions", t => t.TransactionId)
                .Index(t => t.TransactionId)
                .Index(t => t.ProductId);
            
            CreateTable(
                "dbo.UserVouchers",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        UserId = c.String(maxLength: 128),
                        VoucherMasterId = c.String(maxLength: 128),
                        VoucherDiscount = c.Single(nullable: false),
                        CategoryName = c.String(),
                        Quantity = c.Int(nullable: false),
                        DueDate = c.DateTime(nullable: false),
                        MinTransaction = c.Single(nullable: false),
                        IsUsed = c.Boolean(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Users", t => t.UserId)
                .ForeignKey("dbo.VoucherMasters", t => t.VoucherMasterId)
                .Index(t => t.UserId)
                .Index(t => t.VoucherMasterId);
            
            CreateTable(
                "dbo.VoucherMasters",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(),
                        VoucherDiscount = c.Single(nullable: false),
                        VoucherType = c.String(),
                        Quantity = c.Int(nullable: false),
                        isLimitQty = c.Boolean(nullable: false),
                        FromDate = c.DateTime(nullable: false),
                        ToDate = c.DateTime(nullable: false),
                        MinTransaction = c.Single(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.EmailSubscribes",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Email = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.GiftCards",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(),
                        Image = c.Binary(),
                        Price = c.Single(nullable: false),
                        Quantity = c.Int(nullable: false),
                        Visible = c.Boolean(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.NoRekeningPickkadoes",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        AtasNama = c.String(),
                        NomorRekening = c.String(),
                        Bank = c.String(),
                        CabangBank = c.String(),
                        Visible = c.Boolean(nullable: false),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.PostalCodes",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Kelurahan = c.String(),
                        Kecamatan = c.String(),
                        Kabupaten = c.String(),
                        Provinsi = c.String(),
                        Kodepos = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.AspNetRoles",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        Name = c.String(nullable: false, maxLength: 256),
                    })
                .PrimaryKey(t => t.Id)
                .Index(t => t.Name, unique: true, name: "RoleNameIndex");
            
            CreateTable(
                "dbo.AspNetUserRoles",
                c => new
                    {
                        UserId = c.String(nullable: false, maxLength: 128),
                        RoleId = c.String(nullable: false, maxLength: 128),
                    })
                .PrimaryKey(t => new { t.UserId, t.RoleId })
                .ForeignKey("dbo.AspNetRoles", t => t.RoleId, cascadeDelete: true)
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId)
                .Index(t => t.RoleId);
            
            CreateTable(
                "dbo.AspNetUsers",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        UserId = c.String(),
                        Email = c.String(maxLength: 256),
                        EmailConfirmed = c.Boolean(nullable: false),
                        PasswordHash = c.String(),
                        SecurityStamp = c.String(),
                        PhoneNumber = c.String(),
                        PhoneNumberConfirmed = c.Boolean(nullable: false),
                        TwoFactorEnabled = c.Boolean(nullable: false),
                        LockoutEndDateUtc = c.DateTime(),
                        LockoutEnabled = c.Boolean(nullable: false),
                        AccessFailedCount = c.Int(nullable: false),
                        UserName = c.String(nullable: false, maxLength: 256),
                    })
                .PrimaryKey(t => t.Id)
                .Index(t => t.UserName, unique: true, name: "UserNameIndex");
            
            CreateTable(
                "dbo.AspNetUserClaims",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        UserId = c.String(nullable: false, maxLength: 128),
                        ClaimType = c.String(),
                        ClaimValue = c.String(),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.AspNetUserLogins",
                c => new
                    {
                        LoginProvider = c.String(nullable: false, maxLength: 128),
                        ProviderKey = c.String(nullable: false, maxLength: 128),
                        UserId = c.String(nullable: false, maxLength: 128),
                    })
                .PrimaryKey(t => new { t.LoginProvider, t.ProviderKey, t.UserId })
                .ForeignKey("dbo.AspNetUsers", t => t.UserId, cascadeDelete: true)
                .Index(t => t.UserId);
            
            CreateTable(
                "dbo.VendorPayments",
                c => new
                    {
                        Id = c.String(nullable: false, maxLength: 128),
                        TransactionId = c.String(maxLength: 128),
                        Price = c.Single(nullable: false),
                        OngkosKirim = c.Single(nullable: false),
                        ResiNumber = c.String(),
                        CreatedBy = c.String(),
                        CreatedDate = c.DateTime(nullable: false),
                        UpdatedBy = c.String(),
                        UpdatedDate = c.DateTime(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Transactions", t => t.TransactionId)
                .Index(t => t.TransactionId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.VendorPayments", "TransactionId", "dbo.Transactions");
            DropForeignKey("dbo.AspNetUserRoles", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserLogins", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserClaims", "UserId", "dbo.AspNetUsers");
            DropForeignKey("dbo.AspNetUserRoles", "RoleId", "dbo.AspNetRoles");
            DropForeignKey("dbo.UserVouchers", "VoucherMasterId", "dbo.VoucherMasters");
            DropForeignKey("dbo.UserVouchers", "UserId", "dbo.Users");
            DropForeignKey("dbo.Transactions", "UserId", "dbo.Users");
            DropForeignKey("dbo.TransactionProductAttributes", "TransactionId", "dbo.Transactions");
            DropForeignKey("dbo.TransactionProductAttributes", "ProductId", "dbo.Products");
            DropForeignKey("dbo.TransactionPayments", "UserId", "dbo.Users");
            DropForeignKey("dbo.TransactionPayments", "TransactionId", "dbo.Transactions");
            DropForeignKey("dbo.TransactionMemberGroups", "UserId", "dbo.Users");
            DropForeignKey("dbo.TransactionMemberGroups", "TransactionId", "dbo.Transactions");
            DropForeignKey("dbo.TransactionGiftcardMessages", "UserId", "dbo.Users");
            DropForeignKey("dbo.TransactionGiftcardMessages", "TransactionId", "dbo.Transactions");
            DropForeignKey("dbo.Transactions", "StoreId", "dbo.Stores");
            DropForeignKey("dbo.Transactions", "ProductId", "dbo.Products");
            DropForeignKey("dbo.Transactions", "PackageId", "dbo.Packages");
            DropForeignKey("dbo.Reminders", "UserId", "dbo.Users");
            DropForeignKey("dbo.Notifications", "UserId", "dbo.Users");
            DropForeignKey("dbo.NoRekenings", "UserId", "dbo.Users");
            DropForeignKey("dbo.Destinations", "UserId", "dbo.Users");
            DropForeignKey("dbo.ProductThumbnails", "ProductId", "dbo.Products");
            DropForeignKey("dbo.Products", "StoreId", "dbo.Stores");
            DropForeignKey("dbo.ProductStores", "StoreId", "dbo.Stores");
            DropForeignKey("dbo.ProductStores", "ProductId", "dbo.Products");
            DropForeignKey("dbo.Products", "BrandId", "dbo.Brands");
            DropForeignKey("dbo.ProductAttributes", "ProductId", "dbo.Products");
            DropForeignKey("dbo.ProductAttributes", "MasterProductAttributeId", "dbo.MasterProductAttributes");
            DropIndex("dbo.VendorPayments", new[] { "TransactionId" });
            DropIndex("dbo.AspNetUserLogins", new[] { "UserId" });
            DropIndex("dbo.AspNetUserClaims", new[] { "UserId" });
            DropIndex("dbo.AspNetUsers", "UserNameIndex");
            DropIndex("dbo.AspNetUserRoles", new[] { "RoleId" });
            DropIndex("dbo.AspNetUserRoles", new[] { "UserId" });
            DropIndex("dbo.AspNetRoles", "RoleNameIndex");
            DropIndex("dbo.UserVouchers", new[] { "VoucherMasterId" });
            DropIndex("dbo.UserVouchers", new[] { "UserId" });
            DropIndex("dbo.TransactionProductAttributes", new[] { "ProductId" });
            DropIndex("dbo.TransactionProductAttributes", new[] { "TransactionId" });
            DropIndex("dbo.TransactionPayments", new[] { "UserId" });
            DropIndex("dbo.TransactionPayments", new[] { "TransactionId" });
            DropIndex("dbo.TransactionMemberGroups", new[] { "UserId" });
            DropIndex("dbo.TransactionMemberGroups", new[] { "TransactionId" });
            DropIndex("dbo.TransactionGiftcardMessages", new[] { "UserId" });
            DropIndex("dbo.TransactionGiftcardMessages", new[] { "TransactionId" });
            DropIndex("dbo.Transactions", new[] { "StoreId" });
            DropIndex("dbo.Transactions", new[] { "PackageId" });
            DropIndex("dbo.Transactions", new[] { "ProductId" });
            DropIndex("dbo.Transactions", new[] { "UserId" });
            DropIndex("dbo.Reminders", new[] { "UserId" });
            DropIndex("dbo.Notifications", new[] { "UserId" });
            DropIndex("dbo.NoRekenings", new[] { "UserId" });
            DropIndex("dbo.Destinations", new[] { "UserId" });
            DropIndex("dbo.ProductThumbnails", new[] { "ProductId" });
            DropIndex("dbo.ProductStores", new[] { "ProductId" });
            DropIndex("dbo.ProductStores", new[] { "StoreId" });
            DropIndex("dbo.ProductAttributes", new[] { "ProductId" });
            DropIndex("dbo.ProductAttributes", new[] { "MasterProductAttributeId" });
            DropIndex("dbo.Products", new[] { "StoreId" });
            DropIndex("dbo.Products", new[] { "BrandId" });
            DropTable("dbo.VendorPayments");
            DropTable("dbo.AspNetUserLogins");
            DropTable("dbo.AspNetUserClaims");
            DropTable("dbo.AspNetUsers");
            DropTable("dbo.AspNetUserRoles");
            DropTable("dbo.AspNetRoles");
            DropTable("dbo.PostalCodes");
            DropTable("dbo.NoRekeningPickkadoes");
            DropTable("dbo.GiftCards");
            DropTable("dbo.EmailSubscribes");
            DropTable("dbo.VoucherMasters");
            DropTable("dbo.UserVouchers");
            DropTable("dbo.TransactionProductAttributes");
            DropTable("dbo.TransactionPayments");
            DropTable("dbo.TransactionMemberGroups");
            DropTable("dbo.TransactionGiftcardMessages");
            DropTable("dbo.Packages");
            DropTable("dbo.Transactions");
            DropTable("dbo.Reminders");
            DropTable("dbo.Notifications");
            DropTable("dbo.NoRekenings");
            DropTable("dbo.Users");
            DropTable("dbo.Destinations");
            DropTable("dbo.Categories");
            DropTable("dbo.ProductThumbnails");
            DropTable("dbo.ProductStores");
            DropTable("dbo.Stores");
            DropTable("dbo.MasterProductAttributes");
            DropTable("dbo.ProductAttributes");
            DropTable("dbo.Products");
            DropTable("dbo.Brands");
        }
    }
}
