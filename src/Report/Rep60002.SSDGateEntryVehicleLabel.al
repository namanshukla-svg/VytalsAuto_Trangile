report 60002 "SSD Gate Entry Vehicle Label"
{
    Caption = 'Vehicle Label';
    UsageCategory = None;
    RDLCLayout = './Layouts/Vehicle_Labels.rdlc';

    dataset
    {
        dataitem(GateEntryHeader; "Gate Entry Header")
        {
            column(SSDVehicleNo; "SSD Vehicle No.")
            {
            }
            column(SSDDriverName; "SSD Driver Name")
            {
            }
            column(VehicleNoQRCode; VehicleNoQRCode)
            {
            }
            column(SSD_Dock_No_; "SSD Dock No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                BarcodeSymbology2D: Enum "Barcode Symbology 2D";
                BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
                BarcodeString: Text;
            begin
                TestField("SSD Vehicle No.");
                TestField("SSD Driver Name");
                BarcodeFontProvider2D:=Enum::"Barcode Font Provider 2D"::IDAutomation2D;
                BarcodeSymbology2D:=Enum::"Barcode Symbology 2D"::"QR-Code";
                BarcodeString:="SSD Vehicle No.";
                if BarcodeString <> '' then VehicleNoQRCode:=BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
            end;
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
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var VehicleNoQRCode: Text;
}
