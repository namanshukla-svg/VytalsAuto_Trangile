report 60005 "Outward ANI Label"
{
    ApplicationArea = All;
    Caption = 'Outward ANI Label';
    DefaultRenderingLayout = OutwardANILabel;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Order Type", "Order No.", "Order Line No.", "Entry Type", "Prod. Order Comp. Line No.") where("Entry Type" = const("Item Ledger Entry Type"::Output), "Order Type" = const("Inventory Order Type"::Production));
            RequestFilterFields = "Order No.", "Item No.", "Lot No.", "Package No.", "Posting Date";

            column(ProductCode; ItemLedgerEntry."Item No.")
            {
            }
            column(ProductName; ProductName)
            {
            }
            column(AllergenAndWarning; Item."Allergen Warning")
            {
            }
            column(BatchNo; "Lot No.")
            {
            }
            column(ContainerNo; "Package No.")
            {
            }
            column(QuantityAndUOM; QuantityAndUOM)
            {
            }
            column(MfgDate; MfgDate)
            {
            }
            column(ExpiryDate; ExpiryDate)
            {
            }
            column(NetWeight; "Net Weight")
            {
            }
            column(GrossWeight; ItemLedgerEntry."SSD Gross Weight")
            {
            }

            // column(StorageConditionValue; StorageConditionValue)
            // {
            // }
            column(CompanyLogo; CompanyInformation.Picture)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(CompanyAddress1; CompanyAddress1)
            {
            }
            column(CompanyAddress2; CompanyAddress2)
            {
            }
            column(CompanyAddress3; CompanyAddress3)
            {
            }
            column(CompanyEmail; CompanyEmail)
            {
            }
            column(CompanyHomePage; CompanyHomePage)
            {
            }
            column(CompanyRegistrationNo; CompanyRegistrationNo)
            {
            }
            column(CompanyIndustrialClassification; CompanyIndustrialClassification)
            {
            }
            column(VegNonVegLogo; Veg_Non)
            {
            }
            column(StorageCondition; Item."Storage Condition")
            {
            }
            column(QRImage; QrImageBase64Txt)
            {
            }
            column(Lot_No_; "Lot No.")
            {
            }
            column(Package_No_; "Package No.")
            {
            }
            column(No__of_Container; "No. of Container")
            {
            }

            trigger OnAfterGetRecord()
            var
                BarcodeString: Text;
                Char13: Char;
                Char10: Char;
                NewLineTxt: Text;
                ILE: Record "Item Ledger Entry";
                ILE2: Record "Item Ledger Entry";
            begin
                Clear(ProductName);
                Clear(QuantityAndUOM);
                Clear(MfgDate);
                Clear(ExpiryDate);
                // Clear(NetWeight);
                // Clear(GrossWeight);
                Clear(QrInputTxt);
                Clear(QrCodeTxt);
                Clear(QrImageBase64Txt);
                clear(Veg_Non);
                Clear(StorageConditionValue);
                ILE.Reset();
                ILE.SetRange("Document No.", ItemLedgerEntry."Document No.");
                ILE.SetRange("Item No.", ItemLedgerEntry."Item No.");
                ILE.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
                ILE.calcsums(Quantity);


                if ItemLedgerEntry.Quantity <> 0 then begin
                    QuantityAndUOM := Format(ILE.Quantity, 0, '<Precision,2:2><Standard Format,0>');
                    if ItemLedgerEntry."Unit of Measure Code" <> ''
                    then
                        QuantityAndUOM := QuantityAndUOM + ' ' + ItemLedgerEntry."Unit of Measure Code";
                end;
                if ItemLedgerEntry."Date of Manufacturing" <> 0D then
                    MfgDate := Format(ItemLedgerEntry."Date of Manufacturing", 0, '<Day,2>-<Month,2>-<Year4>');
                if ItemLedgerEntry."Expiration Date" <> 0D then ExpiryDate := Format(ItemLedgerEntry."Expiration Date", 0, '<Day,2>-<Month,2>-<Year4>');

                if Item.Get(ItemLedgerEntry."Item No.") then begin
                    ProductName := Item.Description;

                    ProductName := ProductName + '' + Item."Description 2";
                    // if Item."Net Weight" <> 0 then
                    //     NetWeight := Format(Item."Net Weight", 0, '<Precision,2:2><Standard Format,0>');
                    // if Item."Gross Weight" <> 0 then GrossWeight := Format(Item."Gross Weight", 0, '<Precision,2:2><Standard Format,0>');
                    Veg_Non := Format(Item."Veg/Non");
                end;
                Char13 := 13;
                Char10 := 10;
                NewLine := FORMAT(Char13) + FORMAT(Char10);
                QrText := 'Product Code: ' + ItemLedgerEntry."Item No." + NewLine + 'Product name: ' + ProductName + NewLine + 'Batch no.: ' + ItemLedgerEntry."Lot No." + NewLine + 'Packing ID: ' + ItemLedgerEntry."Package No." + NewLine + 'Batch Size: ' + QuantityAndUOM + NewLine + 'Mfg. Date: ' + MfgDate + NewLine + 'Expiry Date: ' + ExpiryDate + NewLine + 'Net Wt.: ' + Format(ItemLedgerEntry."Net Weight") + 'KG' + NewLine + 'Gross Wt.: ' + Format(ItemLedgerEntry."SSD Gross Weight") + 'KG' + NewLine + 'Storage condition: : ' + Item."Storage Condition";
                QrInputTxt := CopyStr(QrText, 1, MaxStrLen(QrInputTxt));
                QrCodeTxt := QrInputTxt;
                GenerateReportQRCode(QrInputTxt, QrImageBase64Txt);


                // ILE2.Reset();
                // ILE2.SetRange("Document No.", ItemLedgerEntry."Document No.");
                // ILE2.SetRange("Item No.", ItemLedgerEntry."Item No.");
                // ILE2.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
                // ILE2.SetRange("Package No.", ItemLedgerEntry."Package No.");
                // ILEEntryCount := ILE2.count;

            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                clear(Veg_Non);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }
    }
    rendering
    {
        layout(OutwardANILabel)
        {
            Type = RDLC;
            LayoutFile = 'Layouts\OutwardANILabel.rdl';
        }
    }
    trigger OnPreReport()
    var
        CityCounty: Text;
    begin
        if not CompanyInformation.Get() then exit;
        CompanyInformation.CalcFields(Picture);
        CompanyName := CompanyInformation.Name;
        if CompanyInformation."Name 2" <> '' then CompanyName := CompanyName + ' ' + CompanyInformation."Name 2";
        CompanyAddress1 := CompanyInformation.Address;
        CompanyAddress2 := CompanyInformation."Address 2";
        CityCounty := CompanyInformation.City;
        if CompanyInformation.County <> '' then
            if CityCounty = '' then
                CityCounty := CompanyInformation.County
            else
                CityCounty := CityCounty + ', ' + CompanyInformation.County;
        CompanyAddress3 := CityCounty;
        if CompanyInformation."Post Code" <> '' then
            if CompanyAddress3 = '' then
                CompanyAddress3 := CompanyInformation."Post Code"
            else
                CompanyAddress3 := CompanyAddress3 + ' ' + CompanyInformation."Post Code";
        CompanyEmail := CompanyInformation."E-Mail";
        CompanyHomePage := CompanyInformation."Home Page";
        CompanyRegistrationNo := CompanyInformation."Registration No.";
        CompanyIndustrialClassification := CompanyInformation."Industrial Classification";
    end;

    trigger OnInitReport()
    begin
        BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
    end;

    local procedure GenerateReportQRCode(InputText: Text; var QRImageBase64: Text)
    var
        Str1: Text[2048];
    begin
        Clear(QRImageBase64);
        if InputText = '' then exit;
        Str1 := CopyStr(InputText, 1, MaxStrLen(Str1));
        QRGenerator.GenerateQRCodeImage(Str1, TempBlob);
        TempBlob.CreateInStream(QRInStream);
        QRImageBase64 := Base64Convert.ToBase64(QRInStream);
    end;

    var
        ILEEntryCount: Integer;
        CompanyInformation: Record "Company Information";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        StorageCondition: Text[150];
        ProductCode: Code[20];
        ProductName: Text[160];
        BatchNo: Code[50];
        ContainerNo: Code[50];
        QuantityAndUOM: Text[50];
        MfgDate: Text[30];
        ExpiryDate: Text[30];
        // NetWeight: Text[30];
        // GrossWeight: Text[30];
        StorageConditionValue: Text[150];
        QRCode: Text;
        CompanyName: Text[150];
        CompanyAddress1: Text[100];
        CompanyAddress2: Text[50];
        CompanyAddress3: Text[100];
        CompanyEmail: Text[80];
        CompanyHomePage: Text[255];
        CompanyRegistrationNo: Text[20];
        CompanyIndustrialClassification: Text[30];
        Item: Record Item;
        Veg_Non: Text[30];
        QrText: Text;
        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
        Char13: Char;
        Char10: Char;
        SrNo1: Integer;
        NewLine: Text;
        QrInputTxt: Text[500];
        QrCodeTxt: Text;
        QrImageBase64Txt: Text;
        QRGenerator: Codeunit "QR Generator";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        QRInStream: InStream;
}
