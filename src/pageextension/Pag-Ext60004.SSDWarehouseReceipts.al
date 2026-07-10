pageextension 60004 "SSD Warehouse Receipts " extends "Warehouse Receipts"
{
    layout
    {
        addafter("Location Code")
        {
            // field("SSD Dock No."; Rec."SSD Dock No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Dock No. field.', Comment = '%';
            // }
            // field("SSD Slot No."; Rec."SSD Slot No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Slot No. field.', Comment = '%';
            // }
            // field("SSD Slot Starting Time"; Rec."SSD Slot Starting Time")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Slot Starting Time field.', Comment = '%';
            // }
            // field("SSD Slot Ending Time"; Rec."SSD Slot Ending Time")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Slot Ending Time field.', Comment = '%';
            // }
            // field("SSD Material Type"; Rec."SSD Material Type")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Material Type field.', Comment = '%';
            // }
            field("SSD Status"; Rec."SSD Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Status field.', Comment = '%';
            }
            field("Source Name"; Rec."SSD Source Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Source Name field.', Comment = '%';
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vendor''s shipment number. It is inserted in the corresponding field on the source document during posting.';
            }
        }
    }
}
