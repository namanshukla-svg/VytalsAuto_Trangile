pageextension 60005 "SSD Warehouse Reecipt" extends "Warehouse Receipt"
{
    layout
    {
        addafter("Posting Date")
        {
            // field("SSD Material Type"; Rec."SSD Material Type")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Material Type field.', Comment = '%';
            // }
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
            field("Gate Entry No."; Rec."Gate Entry No.")
            {
                ApplicationArea = All;
            }
            field("Gate Entry Date"; Rec."Gate Entry Date")
            {
                ApplicationArea = All;
            }
            field("Party name"; Rec."Party name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Material Type field.', Comment = '%';
            }
            field("Bill No."; Rec."Bill No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dock No. field.', Comment = '%';
            }
            field("Bill Amount"; Rec."Bill Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot No. field.', Comment = '%';
            }
            field("Subcontracting"; Rec."Subcontracting")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Slot Starting Time field.', Comment = '%';
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
            // action(Schedule)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Schedule Receipt';
            //     Image = PlannedOrder;
            //     ToolTip = 'Executes the Schedule Receipt action.';

            //     trigger OnAction()
            //     begin
            //         Rec.PlanWarehouseReceipt(Rec);
            //     end;
            // }
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
            action("&PrintMRN")
            {
                ApplicationArea = All;
                Caption = '&Print MRN';
                Ellipsis = true;
                Image = Print;

                trigger OnAction()
                begin
                    Rec.SetRecfilter;
                    Report.RunModal(Report::"Material Receipt Note", true, false, Rec);
                    Rec.Reset;
                end;
            }
            action("Print &Barcode Label")
            {
                ApplicationArea = All;
                Caption = 'Print &Barcode Label';

                trigger OnAction()
                var
                    ReservationEntry1: Record "Reservation Entry";
                    BarcodeReceipt: Report "BARCODE LEBEL RECEIPT 4x3";
                begin
                    // <<<< ALLE[5.51]
                    ReservationEntry1.Reset;
                    ReservationEntry1.SetCurrentkey("MRN No.", "Item No.", "MRN Line No.", "Lot No.");
                    ReservationEntry1.SetRange(ReservationEntry1."MRN No.", Rec."No.");
                    if ReservationEntry1.FindFirst then begin
                        BarcodeReceipt.SetTableview(ReservationEntry1);
                        BarcodeReceipt.RunModal;
                    end;
                    // >>>> ALLE[5.51]
                end;
            }
            action("Posted Gate Entry")
            {
                ApplicationArea = All;
                Caption = 'Posted Gate Entry';

                trigger OnAction()
                var
                    FrmPostedGateInList: Page "Posted Gate In List";
                    PostedGateHeaderLocal: Record "SSD Posted Gate Header";
                    WHReceiptLineLocal: Record "Warehouse Receipt Line";
                begin
                    //CF001 St
                    Clear(FrmPostedGateInList);
                    PostedGateHeaderLocal.Reset;
                    WHReceiptLineLocal.Reset;
                    WHReceiptLineLocal.SetRange("No.", Rec."No.");
                    WHReceiptLineLocal.SetRange("Location Code", Rec."Location Code");
                    if WHReceiptLineLocal.Find('-') then
                        repeat
                            PostedGateHeaderLocal.Get(WHReceiptLineLocal."Gate Entry no.");
                            PostedGateHeaderLocal.Mark(true);
                        until WHReceiptLineLocal.Next = 0;
                    PostedGateHeaderLocal.MarkedOnly(true);
                    FrmPostedGateInList.SetTableview(PostedGateHeaderLocal);
                    FrmPostedGateInList.RunModal;
                    //CF001 St
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
            // actionref(Schedule_Promoted; Schedule)
            // {
            // }
            actionref(Reopen_Promoted; Reopen)
            {
            }
            actionref(Sync_Promoted; Sync)
            {
            }
            actionref(Print_Promoted; Print)
            {
            }
            actionref(PrintMRN_Promoted; "&PrintMRN")
            {
            }
            actionref("Print &Barcode Label_Promoted"; "Print &Barcode Label")
            {
            }
        }
        addafter("Posted &Whse. Receipts_Promoted")
        {
             actionref("Posted Gate Entry_Promoted"; "Posted Gate Entry")
            {
            }
        }
    }
    procedure GetUserNameFromSecurityId(UserSecurityID: Guid): Code[50]
    var
        User: Record User;
        NullGuid: Guid;
    begin
        if UserSecurityID = NullGuid then
            exit('')
        else begin
            User.Get(UserSecurityID);
            exit(User."User Name");
        end;
    end;
}
