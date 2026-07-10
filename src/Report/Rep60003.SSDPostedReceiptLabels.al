report 60003 "SSD Posted Receipt Labels"
{
    ApplicationArea = All;
    Caption = 'Posted Receipt Labels';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/PostedReceipts_Labels.rdlc';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            //PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                RequestFilterFields = Type, "No.";
                //PrintOnlyIfDetail = true;
                DataItemLink = "Document No." = field("No.");

                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    //PrintOnlyIfDetail = true;
                    DataItemTableView = sorting("Document No.", "Document Type", "Document Line No.") where("Document Type" = const("Purchase Receipt"));
                    DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
                    RequestFilterFields = "Package No.";

                    column(ItemNo; "Item No.")
                    {
                    }
                    column(Quantity__Base_; Quantity)
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
                    trigger OnAfterGetRecord()
                    var
                        Item: Record "Item";
                        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
                        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
                        BarcodeString: Text;
                    begin
                        Item.SetLoadFields(Item.Description, "Description 2", "Base Unit of Measure");
                        Item.Get("Item No.");
                        BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
                        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
                        BarcodeString := "Item No." + ',' + Item.Description + ',' + Item."Description 2" + ',' + Format(Quantity) + ',' + Item."Base Unit of Measure" + ',' + "Lot No." + ',' + "Package No.";
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
    var
        LotNoQRCode: Text;
}
