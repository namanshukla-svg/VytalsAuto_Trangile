page 60029 "SSD Shipment Dock Out"
{
    ApplicationArea = All;
    Caption = 'Shipment Dock Out';
    PageType = Card;
    SourceTable = "SSD Dock";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(QRText; QRText)
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle QR Code';
                    ExtendedDatatype = Barcode;
                    ToolTip = 'Specifies the value of the Vehicle QR value field.';

                    trigger OnValidate()
                    begin
                        SSDDockManagement.ProcessShipmentDockOut(Rec, QRText);
                        QRText:='';
                    end;
                }
            }
        }
    }
    var SSDDockManagement: Codeunit "SSD Dock Management";
    QRText: Text;
}
