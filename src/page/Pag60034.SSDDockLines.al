page 60034 "SSD Dock Lines"
{
    ApplicationArea = All;
    Caption = 'Dock Lines';
    PageType = List;
    SourceTable = "SSD Dock Lines";
    InsertAllowed = false;
    ModifyAllowed = false;
    //DeleteAllowed = false;
    Editable = false;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ToolTip = 'Specifies the value of the Entry Type field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Dock No."; Rec."Dock No.")
                {
                    ToolTip = 'Specifies the value of the Dock No. field.', Comment = '%';
                }
                field("Time Slot No."; Rec."Time Slot No.")
                {
                    ToolTip = 'Specifies the value of the Time Slot No. field.', Comment = '%';
                }
                field("Time Slot Starting Time"; Rec."Time Slot Starting Time")
                {
                    ToolTip = 'Specifies the value of the Slot Starting Time field.', Comment = '%';
                }
                field("Time Slot Ending Time"; Rec."Time Slot Ending Time")
                {
                    ToolTip = 'Specifies the value of the Slot Ending Time field.', Comment = '%';
                }
                field("Planning No."; Rec."Planning No.")
                {
                    ToolTip = 'Specifies the value of the Planning No. field.', Comment = '%';
                }
                field("Planning Date"; Rec."Planning Date")
                {
                    ToolTip = 'Specifies the value of the Planning Date field.', Comment = '%';
                }
                field("Gate Entry No."; Rec."Gate Entry No.")
                {
                    ToolTip = 'Specifies the value of the Gate Entry No. field.', Comment = '%';
                }
                field("Gate Entry Date"; Rec."Gate Entry Date")
                {
                    ToolTip = 'Specifies the value of the Gate Entry Date field.', Comment = '%';
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ToolTip = 'Specifies the value of the Driver Code field.', Comment = '%';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update Gate Entry")
            {
                ApplicationArea = All;
                Caption = 'Update Gate Entry No.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateDescription;
                ToolTip = 'Update Gate Entry No.';
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.UpdateGateEntry(Rec."Planning No.");
                end;
            }
            action("Delete Line")
            {
                ApplicationArea = All;
                Caption = 'Delete Line';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = UpdateDescription;
                ToolTip = 'Delete Line';
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.DeleteLine(Rec."Entry No.");
                end;
            }
        }
    }
    trigger OnModifyRecord(): Boolean var
    // UserSetup: Record "User Setup";
    begin
    // UserSetup.Get(UserId);
    // if not UserSetup."Sepecial Permission" then
    //     Error('You are not authorized. Please contact to administrator.');
    end;
}
