report 60001 "Inward Label"
{
    Caption = 'Inward Label Report';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts\InwardLable.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            RequestFilterFields = "Item No.", "Document No.";

            column(Lot_No_; "Lot No.")
            {
            }
            // column(Serial_No_; "Serial No.")
            // {
            // }
            column(ExpiryDate; "Expiration Date")
            {
            }
            column(Serial_No_; "Package No.")
            {
            }
            column(MRN_No_; "Document No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Item_No_; "Item No.")
            {
            }
            column(Vendor_Lot_No_; "Vendor Lot No.")
            {
            }
            column(ProductCode; "Item Ledger Entry"."Item No.")
            {
            }
            column(ProductName; ProductNameTxt)
            {
            }
            column(QuantityUOM; QuantityUOMTxt)
            {
            }
            column(MfgDate; "Item Ledger Entry"."Date of Manufacturing")
            {
            }
            column(NetWt; NetWeightTxt)
            {
            }
            column(GrossWt; "Item ledger entry"."SSD Gross Weight")
            {
            }
            column(VendorNo; "Source No.")
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
            column(QRText; QrInputTxt)
            {
            }
            column(QRCode; QrCodeTxt)
            {
            }
            column(QRImage; QrImageBase64Txt)
            {
            }
            column(BatchandVendorLotNo; BatchandVendorLotNo)
            {
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                // "Item Ledger Entry".SetFilter("Lot No.", '<>%1', '');
                // "Item Ledger Entry".SetFilter("Package No.", '<>%1', '');
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                ExpiryDate: Date;
                ProductNameForQR: Text;
                QrPayload: Text;
                Char13: Char;
                Char10: Char;
                NewLineTxt: Text;
            begin
                Clear(ExpiryDateTxt);
                Clear(BatchandVendorLotNo);
                Clear(FirstPackID);
                Clear(ProductNameTxt);
                Clear(QuantityUOMTxt);
                Clear(ExpiryDateTxt);
                Clear(NetWeightTxt);
                // Clear(GrossWeightTxt);
                Clear(VendorNoTxt);
                Clear(StorageConditionTxt);
                Clear(AllergenWarningTxt);
                Clear(VegNonVegLogoTxt);
                Clear(QrInputTxt);
                Clear(QrCodeTxt);
                Clear(QrImageBase64Txt);
                BatchandVendorLotNo := "Item Ledger Entry"."Vendor Lot No." + ' / ' + "Item Ledger Entry"."Lot No.";
                ExpiryDateTxt := Format("Item Ledger Entry"."Expiration Date", 0, '<Day,2>-<Month,2>-<Year4>');
                FirstPackID := "Item Ledger Entry"."Package No.";
                QuantityUOMTxt := StrSubstNo('%1 %2', Format("Item Ledger Entry".Quantity), "Item Ledger Entry"."Unit of Measure Code");
                if ItemRec.Get("Item Ledger Entry"."Item No.") then begin
                    NetWeightTxt := Format(ItemRec."Net Weight" * "Item Ledger Entry".Quantity);
                    // GrossWeightTxt := Format(ItemRec."Gross Weight");
                    StorageConditionTxt := ItemRec."Storage Condition";
                    AllergenWarningTxt := ItemRec."Allergen Warning";
                    VegNonVegLogoTxt := Format(ItemRec."Veg/Non");
                    ProductNameTxt := ItemRec.Description + ' ' + ItemRec."Description 2";
                end;
                ProductNameForQR := ProductNameTxt;
                Char13 := 13;
                Char10 := 10;
                NewLineTxt := Format(Char13) + Format(Char10);
                QrPayload := 'MRN No:' + "Item Ledger Entry"."Document No." + NewLineTxt +
                'Product Code: ' + "Item Ledger Entry"."Item No." + NewLineTxt + 'Product name: ' + ProductNameForQR + NewLineTxt + 'Vendor/Vytal''s Batch No.:' + BatchandVendorLotNo + NewLineTxt + 'Pack ID.: ' + FirstPackID + NewLineTxt + 'Quantity & UoM: ' + QuantityUOMTxt + NewLineTxt + 'Mfg. Date: ' + Format("Item Ledger Entry"."Date of Manufacturing", 0, '<Day,2>-<Month,2>-<Year4>') + NewLineTxt + 'Expiry Date: ' + ExpiryDateTxt + NewLineTxt + 'Net Wt.: ' + NetWeightTxt + NewLineTxt + 'Gross Wt.: ' + Format("Item Ledger Entry"."SSD Gross Weight") + NewLineTxt + 'Storage Condition: ' + StorageConditionTxt + NewLineTxt + 'Allergen Warning: ' + AllergenWarningTxt + NewLineTxt + 'Vendor No.: ' + VendorNoTxt;
                QrInputTxt := CopyStr(QrPayload, 1, MaxStrLen(QrInputTxt));
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
        myInt: Integer;
    begin
        if not CompanyInformation.Get() then exit;
        CompanyInformation.CalcFields(Picture);
    end;

    trigger OnInitReport()
    begin
        BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
    end;

    var
        ItemRec: Record Item;
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ProductNameTxt: Text[200];
        QuantityUOMTxt: Text[100];
        MfgDateTxt: Text[30];
        ExpiryDateTxt: Text[30];
        NetWeightTxt: Text[30];
        // GrossWeightTxt: Text[30];
        VendorNoTxt: Text[20];
        StorageConditionTxt: Text[150];
        AllergenWarningTxt: Text[150];
        VegNonVegLogoTxt: Text[10];
        CompanyInformation: Record "Company Information";
        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        FirstLotNo: Code[50];
        FirstPackID: Code[50];
        QrInputTxt: Text[500];
        QrCodeTxt: Text;
        QrImageBase64Txt: Text;
        QRGenerator: Codeunit "QR Generator";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        QRInStream: InStream;
        BatchandVendorLotNo: Text;

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
    // local procedure GetItemLedgerEntrydetails(PurchRcptLine: Record "Purch. Rcpt. Line")
    // var
    //     ItemLedgerEntryLookup: Record "Item Ledger Entry";
    // begin
    //     ItemLedgerEntryLookup.SetRange("Document No.", PurchRcptLine."Document No.");
    //     ItemLedgerEntryLookup.SetRange("Item No.", PurchRcptLine."No.");
    //     ItemLedgerEntryLookup.SetRange("Document Line No.", PurchRcptLine."Line No.");
    //     if ItemLedgerEntryLookup.FindFirst() then begin
    //     end;
    // end;
}
