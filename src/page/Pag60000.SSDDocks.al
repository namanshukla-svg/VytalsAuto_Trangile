page 60000 "SSD Docks"
{
    ApplicationArea = All;
    Caption = 'Docks';
    PageType = List;
    SourceTable = "SSD Dock";
    DelayedInsert = true;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Planned Receipts"; Rec."Planned Receipts")
                {
                    ToolTip = 'Specifies the value of the Planned Receipts field.', Comment = '%';
                }
                field("Planned Shipments"; Rec."Planned Shipments")
                {
                    ToolTip = 'Specifies the value of the Planned Shipments field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(TimeSlots)
            {
                ApplicationArea = All;
                Caption = 'Time Slots';
                Image = Timesheet;
                ToolTip = 'Executes the Time Slots action.';
                RunObject = Page "SSD Dock Time Slots";
                RunPageLink = "Dock No."=field(Code), "Location Code"=field("Location Code");
            }
        }
        area(Promoted)
        {
            actionref(TimeSlots_Promoted; TimeSlots)
            {
            }
        }
    }
}
