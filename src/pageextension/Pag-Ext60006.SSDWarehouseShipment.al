pageextension 60006 "SSD Warehouse Shipment" extends "Warehouse Shipment"
{
    layout
    {
        addafter("Posting Date")
        {
            field("SSD Combined With"; Rec."SSD Combined With")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Combined With field.', Comment = '%';
            }
            field("SSD Dock No."; Rec."SSD Dock No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dock No. field.', Comment = '%';
            }
            field("SSD Slot No."; Rec."SSD Slot No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot No. field.', Comment = '%';
            }
            field("SSD Slot Starting Time"; Rec."SSD Slot Starting Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot Starting Time field.', Comment = '%';
            }
            field("SSD Slot Ending Time"; Rec."SSD Slot Ending Time")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot Ending Time field.', Comment = '%';
            }
            field(SSDCreatedBy; GetUserNameFromSecurityId(Rec.SystemCreatedBy))
            {
                Caption = 'Created By';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                Editable = false;
            }
            field(SSDModifiedBy; GetUserNameFromSecurityId(Rec.SystemModifiedBy))
            {
                Caption = 'Created By';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                Editable = false;
            }
        }
        addlast(Shipping)
        {
            field("SSD Transport Method"; Rec."SSD Transport Method")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transport Method field.', Comment = '%';
            }
            field("SSD Mode of Transport"; Rec."SSD Mode of Transport")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mode of Transport field.', Comment = '%';
            }
            field("SSD Vehicle No."; Rec."SSD Vehicle No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vehicle No. field.', Comment = '%';
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action("Print Automation")
            {
                ApplicationArea = All;
                Caption = 'Print Automation';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                ToolTip = 'Executes the Print Automation action.';

                trigger OnAction()
                var
                    WhseShptHdr: Record "Warehouse Shipment Header";
                begin
                    WhseShptHdr.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"SSD Dispatch Slip Automation", true, false, WhseShptHdr);
                end;
            }
        }
    }
    procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]var
        User: Record User;
        NullGuid: Guid;
    begin
        if UserSecurityID = NullGuid then exit('');
        User.Get(UserSecurityID);
        exit(User."User Name");
    end;
}
