page 60009 "SSD Dock Time Slots"
{
    ApplicationArea = All;
    Caption = 'Dock Time Slots';
    PageType = List;
    SourceTable = "SSD Dock Time Slots";
    DelayedInsert = true;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Slot No."; Rec."Slot No.")
                {
                    ToolTip = 'Specifies the value of the Slot No. field.', Comment = '%';
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ToolTip = 'Specifies the value of the Starting Time field.', Comment = '%';
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ToolTip = 'Specifies the value of the Ending Time field.', Comment = '%';
                }
                field("Planned Receipts"; Rec."Planned Receipts")
                {
                    ToolTip = 'Specifies the value of the Planned Receipts field.', Comment = '%';
                }
                field("Planned Shipments"; Rec."Planned Shipments")
                {
                    ToolTip = 'Specifies the value of the Planned Shipments field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
            }
        }
    }
}
