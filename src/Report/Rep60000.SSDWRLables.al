report 60000 "SSD WR Lables"
{
    Caption = 'Receipt Lables';
    WordMergeDataItem = "Warehouse Receipt Header";
    UsageCategory = ReportsAndAnalysis;
    // RDLCLayout = './Layouts/WR_Labels.rdlc'; //IG_DS_before
    RDLCLayout = './Layouts/WR_Labels.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Warehouse Receipt Header"; "Warehouse Receipt Header")
        {
            //PrintOnlyIfDetail = true;
            dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
            {
                RequestFilterFields = "Item No.";
                //PrintOnlyIfDetail = true;
                DataItemLink = "No." = field("No.");

                dataitem(ReservationEntry; "Reservation Entry")
                {
                    //PrintOnlyIfDetail = true;
                    DataItemLink = "Source Subtype" = field("Source Subtype"), "Source Type" = field("Source Type"), "Source ID" = field("Source No."), "Source Ref. No." = field("Line No.");
                    RequestFilterFields = "Package No.";

                    column(ItemNo; "Item No.")
                    {
                    }
                    column(Quantity__Base_; "Quantity (Base)")
                    {
                    }
                    column(Lot_No_; "Lot No.")
                    {
                    }
                    column(Package_No_; "Package No.")
                    {
                    }
                    column(LotNoQRCode; LotNoQRCode)
                    {
                    }
                    column(QRCode; QRCode)
                    {
                    }
                    column(Item_Ledger_Entry___Item_No_________Item1_Description_____Item1__Description_2_; "Item No." + ' - ' + Item.Description + ' ' + Item."Description 2")
                    {
                    }
                    column(QUANTITY______________________FORMAT_Qty_______Item1__Base_Unit_of_Measure_; 'QUANTITY                    ' + Format(Quantity) + '  ' + Item."Base Unit of Measure")
                    {
                    }
                    column(LOT_NO_________________________FORMAT__Item_Ledger_Entry___Lot_No___; 'LOT NO.                        ' + Format("Lot No."))
                    {
                    }
                    column(MFG__DATE________; 'MFG. DATE                   ')
                    {
                    }
                    column(PostingDate; "Creation Date") //IG_DS "Posting Date")
                    {
                    }
                    column(BEST_USED_BEFORE_____; 'BEST USED BEFORE    ')
                    {
                    }
                    column(ExpirationDate; "Expiration Date")
                    {
                    }
                    column(NET_WT__GR__WT_____________FORMAT_WT______FORMAT_GWT____KGS_; 'NET WT./GR. WT.          ' + Format(WT) + '/' + Format("SSD Gross Weight") + ' KGS')
                    {
                    }
                    column(PackageNo; 'PACKAGE NO.                 ' + "Package No.")
                    {
                    }
                    column(V000000000000000000_____; '*' + '000000000000000000' + '*')
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
                        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
                        BarcodeString: Text;
                    begin
                        Item.SetLoadFields(Item.Description, "Description 2", "Base Unit of Measure");
                        Item.Get("Item No.");
                        BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
                        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
                        BarcodeString := "Item No." + ',' + Item.Description + ',' + Item."Description 2" + ',' + Format("Qty. to Handle (Base)") + ',' + Item."Base Unit of Measure" + ',' + "Lot No." + ',' + "Package No.";
                        if BarcodeString <> '' then LotNoQRCode := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
                    end;
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    }
    trigger OnPreReport()
    var
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture, CompanyInfo."New Logo1", CompanyInfo."New Logo2");
    end;

    var
        CompanyInfo: Record "Company Information";
        LotNoQRCode: Text;
        Item: Record "Item";
        WT: Decimal;
        QRCode: text;
}
