report 60007 "Outward Others_Label"
{
    Caption = 'Outward Others_Label';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts//Outward.rdl';

    dataset
    {
        dataitem("Reservation Entry"; "Reservation Entry")
        {
            RequestFilterFields = "Lot No.", "Package No.", "Item No.";

            column(Serial_No_; "Serial No.")
            {
            }
            column(Lot_No_; "Lot No.")
            {
            }
            column(Package_No_; "Lot Wise Package No.")
            {
            }
            column(ProductCode; "Reservation Entry"."Item No.")
            {
            }
            column(ProductName; ProductNameTxt)
            {
            }
            column(QuantityUOM; QuantityUOMTxt)
            {
            }
            column(MfgDate; Format("Reservation Entry"."Date of Manufacturing", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(ExpiryDate; Format("Reservation Entry"."Expiration Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(NetWt; NetWeightTxt)
            {
            }
            column(GrossWt; "Reservation Entry"."SSD Gross Weight")
            {
            }

            column(StorageCondition; StorageConditionTxt)
            {
            }
            column(AllergenWarning; AllergenWarningTxt)
            {
            }
            column(VegNonVegLogo; VegNonVegLogoTxt)
            {
            }
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
            column(QRImage; QrImageBase64Txt)
            {
            }
            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                SetFilter(Quantity, '>%1', 0);
            end;

            trigger OnAfterGetRecord()
            var
                NewLineTxt: Text;
                QrPayload: Text;
                Char13: Char;
                Char10: Char;
            begin
                Clear(ProductNameTxt);
                Clear(LotNoTxt);
                Clear(PackageNoTxt);
                Clear(QuantityUOMTxt);
                Clear(MfgDateTxt);
                Clear(ExpiryDateTxt);
                Clear(NetWeightTxt);
                // Clear(GrossWeightTxt);
                Clear(StorageConditionTxt);
                Clear(AllergenWarningTxt);
                Clear(VegNonVegLogoTxt);
                Clear(QrInputTxt);
                Clear(QrCodeTxt);
                Clear(QrImageBase64Txt);
                QuantityUOMTxt := StrSubstNo('%1', Format(ABS("Reservation Entry".Quantity)));
                if ItemRec.Get("Reservation Entry"."Item No.") then begin
                    ProductNameTxt := ItemRec.Description;
                    QuantityUOMTxt := QuantityUOMTxt + ' ' + ItemRec."Base Unit of Measure";
                    ProductNameTxt := ProductNameTxt + ' ' + ItemRec."Description 2";
                    if ProductNameTxt = '' then ProductNameTxt := "Reservation Entry".Description;
                    NetWeightTxt := Format(ItemRec."Net Weight" * abs("Reservation Entry".Quantity));
                    // GrossWeightTxt := Format(ItemRec."Gross Weight");
                    StorageConditionTxt := ItemRec."Storage Condition";
                    AllergenWarningTxt := ItemRec."Allergen Warning";
                    VegNonVegLogoTxt := Format(ItemRec."Veg/Non");
                end;
                Char13 := 13;
                Char10 := 10;
                NewLineTxt := Format(Char13) + Format(Char10);
                QrPayload := 'Product Code: ' + "Reservation Entry"."Item No." + NewLineTxt + 'Product name: ' + ProductNameTxt + NewLineTxt + 'Batch no.: ' + "Reservation Entry"."Lot No." + NewLineTxt + 'Container no.: ' + "Reservation Entry"."Lot Wise Package No." + NewLineTxt + 'Quantity & UoM: ' + QuantityUOMTxt + NewLineTxt + 'Mfg. Date: ' + FORMAT("Reservation Entry"."Date of Manufacturing", 0, '<Day,2>-<Month,2>-<Year4>') + NewLineTxt + 'Expiry Date: ' + FORMAT("Reservation Entry"."Expiration Date", 0, '<Day,2>-<Month,2>-<Year4>') + NewLineTxt + 'Net Wt.: ' + NetWeightTxt + NewLineTxt + 'Gross Wt.: ' + Format("Reservation Entry"."SSD Gross Weight") + NewLineTxt;
                QrText := QrPayload;
                QrInputTxt := CopyStr(QrText, 1, MaxStrLen(QrInputTxt));
                QrCodeTxt := QrInputTxt;
                GenerateReportQRCode(QrInputTxt, QrImageBase64Txt);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        CityCounty: Text;
    begin
        if not CompanyInformation.Get() then exit;
        CompanyInformation.CalcFields(Picture);
        CompanyName := CompanyInformation.Name;
        if CompanyInformation."Name 2" <> '' then CompanyName := CompanyName + ', ' + CompanyInformation."Name 2";
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

    // local procedure GetCustomItemFieldText(var ItemValue: Record Item; FieldName: Text): Text[150]
    // var
    //     ItemRecRef: RecordRef;
    //     ItemFieldRef: FieldRef;
    // begin
    //     ItemRecRef.GetTable(ItemValue);
    //     if not ItemRecRef.FieldExist(FieldName) then exit('');
    //     ItemFieldRef := ItemRecRef.Field(FieldName);
    //     exit(CopyStr(Format(ItemFieldRef.Value), 1, 150));
    // end;

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
        ItemRec: Record Item;
        ReservationEntry: Record "Reservation Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        ProductNameTxt: Text[200];
        LotNoTxt: Text[250];
        PackageNoTxt: Text[250];
        QuantityUOMTxt: Text[100];
        MfgDateTxt: Text[30];
        ExpiryDateTxt: Text[30];
        NetWeightTxt: Text[30];
        // GrossWeightTxt: Text[30];
        StorageConditionTxt: Text[150];
        AllergenWarningTxt: Text[150];
        VegNonVegLogoTxt: Text[150];
        CompanyInformation: Record "Company Information";
        CompanyName: Text[150];
        CompanyAddress1: Text[100];
        CompanyAddress2: Text[50];
        CompanyAddress3: Text[100];
        CompanyEmail: Text[80];
        CompanyHomePage: Text[255];
        CompanyRegistrationNo: Text[20];
        CompanyIndustrialClassification: Text[30];
        QrCode: Text;
        Qrtext: text;
        QrImageBase64Txt: Text;
        QRGenerator: Codeunit "QR Generator";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        QRInStream: InStream;
        QrInputTxt: Text[500];
        QrCodeTxt: Text;
}
