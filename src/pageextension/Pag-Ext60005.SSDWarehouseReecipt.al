pageextension 60005 "SSD Warehouse Reecipt" extends "Warehouse Receipt"
{
    layout
    {
        addafter("Posting Date")
        {
            field("SSD Material Type"; Rec."SSD Material Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Material Type field.', Comment = '%';
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
            field("SSD Status"; Rec."SSD Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Status field.', Comment = '%';
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
                Caption = 'Modified By';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                Editable = false;
            }
            field("SSD Shipment Date"; Rec."SSD Shipment Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Invoice Date field.', Comment = '%';
            }
        }
    }
    actions
    {
        modify("Use Filters to Get Src. Docs.")
        {
            Visible = false;
        }
        modify("Use Filters to Get Src. Docs._Promoted")
        {
            Visible = false;
        }
        addlast("F&unctions")
        {
            action(Schedule)
            {
                ApplicationArea = All;
                Caption = 'Schedule Receipt';
                Image = PlannedOrder;
                ToolTip = 'Executes the Schedule Receipt action.';

                trigger OnAction()
                begin
                    Rec.PlanWarehouseReceipt(Rec);
                end;
            }
            action(Reopen)
            {
                ApplicationArea = All;
                Caption = 'Re-Open Receipt';
                Image = PlannedOrder;
                ToolTip = 'Executes the Re-Open Receipt action.';

                trigger OnAction()
                begin
                    Rec.ReOpenWarehouseReceipt(Rec);
                end;
            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print Labels';
                Image = Print;
                ToolTip = 'Executes the Print Labels action.';

                trigger OnAction()
                var
                    WarehouseReceiptHeader: Record "Warehouse Receipt Header";
                begin
                    WarehouseReceiptHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"SSD WR Lables", true, true, WarehouseReceiptHeader);
                end;
            }
            action(Sync)
            {
                ApplicationArea = All;
                Caption = 'Sync with WMS';
                Image = OutlookSyncFields;
                ToolTip = 'Executes the Sync with WMS action.';

                trigger OnAction()
                var
                    SSDReservationManagement: Codeunit "SSD Reservation Management";
                begin
                    SSDReservationManagement.SyncWarehouseReceipt(Rec);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(Schedule_Promoted; Schedule)
            {
            }
            actionref(Reopen_Promoted; Reopen)
            {
            }
            actionref(Sync_Promoted; Sync)
            {
            }
            actionref(Print_Promoted; Print)
            {
            }
        }
    }
    procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]var
        User: Record User;
        NullGuid: Guid;
    begin
        if UserSecurityID = NullGuid then exit('')
        else
        begin
            User.Get(UserSecurityID);
            exit(User."User Name");
        end;
    end;
}
