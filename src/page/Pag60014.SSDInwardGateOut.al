page 60014 "SSD Inward Gate-Out"
{
    ApplicationArea = All;
    Caption = 'Inward Gate Out';
    PageType = Card;
    UsageCategory = Lists;

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
                    ToolTip = 'Specifies the value of the Vehicle QR value field.';

                    trigger OnValidate()
                    begin
                        SSDDockManagement.ProcessInwardGateOut(QRText);
                        QRText:='';
                    end;
                }
            }
        }
    }
    var SSDDockManagement: Codeunit "SSD Gate Entry Post";
    QRText: Text;
}
