page 60143 "Warehouse Ship List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Warehouse Shipment Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = where("Outward gate Entry"=filter(false), "Posted Outward gate Entry"=filter(false));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Merged; Rec.Merged)
                {
                    ApplicationArea = all;
                }
                field("Outward gate Entry"; Rec."Outward gate Entry")
                {
                    ApplicationArea = all;
                }
                field("Posted Outward gate Entry"; Rec."Posted Outward gate Entry")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                // field("SSD Dock No."; Rec."SSD Dock No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("SSD Slot No."; Rec."SSD Slot No.")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("SSD Slot Starting Time"; Rec."SSD Slot Starting Time")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                // field("SSD Slot Ending Time"; Rec."SSD Slot Ending Time")
                // {
                //     ApplicationArea = all;
                //     Editable = false;
                // }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                trigger OnAction()
                begin
                end;
            }
        }
    }
}
