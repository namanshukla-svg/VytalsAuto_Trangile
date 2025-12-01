pageextension 60030 "SSD Posted Whse. Receipt List" extends "Posted Whse. Receipt List"
{
    layout
    {
        addafter("Vendor No.")
        {
            field("SSD Source Name"; Rec."SSD Source Name")
            {
                ApplicationArea = All;
                Caption = 'Vendor Name';
                ToolTip = 'Specifies the value of the Source Name field.', Comment = '%';
                Visible = false;
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vendor''s shipment number. It is inserted in the corresponding field on the source document during posting.';
            }
        }
    }
}
