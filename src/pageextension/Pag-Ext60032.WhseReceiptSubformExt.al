pageextension 60032 "Whse. Receipt SubformExt" extends "Whse. Receipt Subform"
{
    layout
    {
        modify("Bin Code")
        {
            Visible = true;
        }
        addafter("Direct Unit Cost")
        {
            field("No.2"; Rec."No.2")
            {
                ApplicationArea = All;
            }

            field("Manufacturing Date"; Rec."Manufacturing Date")
            {
                ApplicationArea = All;
            }

            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }

            field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
            }

            field("Vendor Item Description"; Rec."Vendor Item Description")
            {
                ApplicationArea = All;
            }

            field("Supplier Batch No."; Rec."Supplier Batch No.")
            {
                ApplicationArea = All;
            }

            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }

            field("Qty. On Purch. Order"; Rec."Qty. On Purch. Order")
            {
                ApplicationArea = All;
            }

            field("Purchase price"; Rec."Purchase price")
            {
                ApplicationArea = All;
            }

            field("Qty. On Invoice"; Rec."Qty. On Invoice")
            {
                ApplicationArea = All;
            }

            field("Actual Qty. to receive"; Rec."Actual Qty. to receive")
            {
                ApplicationArea = All;
            }

            field("Shortage Qty"; Rec."Shortage Qty.")
            {
                ApplicationArea = All;
            }

            field("Delivery Challan"; Rec."Delivery Challan")
            {
                ApplicationArea = All;
            }

            field("Delivery Challan Sent Item"; Rec."Delivery Challan Sent Item")
            {
                ApplicationArea = All;
            }

            field("Scrap item"; Rec."Scrap item")
            {
                ApplicationArea = All;
            }

            field("Scrap Qty."; Rec."Scrap Qty.")
            {
                ApplicationArea = All;
            }

            field("Scrap Location"; Rec."Scrap Location")
            {
                ApplicationArea = All;
            }

            field("Scarp Bin"; Rec."Scrap Bin")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Get Gate Entry Lines")
        {
            action("Show Form")
            {
                ApplicationArea = All;
                Caption = 'Show Form';
                Image = ShowChart;

                trigger OnAction()
                begin
                    ShowSubOrderDetailsForm;
                end;
            }
            action("Applied Entries")
            {
                ApplicationArea = All;
                Caption = 'Applied Entries';
                Image = Apply;

                trigger OnAction()
                begin
                    ShowItemEntry;
                end;
            }
            action("Application Entries")
            {
                ApplicationArea = All;
                Caption = 'Application Entries';
                Image = PostApplication;

                trigger OnAction()
                begin
                    SelectItemEntry;
                end;
            }
        }
    }
    procedure SelectItemEntry()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgerEntries: Page "Item Ledg. Entries";
        ItemLedgEntryBuff: Record "SSD Item Ledger Entry Buffer";
        PurchaseLine: Record "Purchase Line";
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
        SubOrderCompListVend.Reset;
        SubOrderCompListVend.SetRange("Document No.", Rec."Source No.");
        SubOrderCompListVend.SetRange("Document Line No.", Rec."Source Line No.");
        SubOrderCompListVend.SetRange("Parent Item No.", Rec."Item No.");
        if SubOrderCompListVend.FindFirst then begin
            ItemLedgEntryBuff.Reset;
            ItemLedgEntryBuff.SetCurrentkey("Item No.", "Location Code");
            ItemLedgEntryBuff.SetRange("Item No.", SubOrderCompListVend."Item No.");
            ItemLedgEntryBuff.SetRange("Location Code", SubOrderCompListVend."Vendor Location");
            //    ItemLedgEntryBuff.SETRANGE("Bin Code",SubOrderCompListVend."Vendor Bin Code");
            if ItemLedgEntryBuff.Find('-') then ItemLedgEntryBuff.DeleteAll;
            ItemLedgEntry.Reset;
            ItemLedgEntry.SetCurrentkey("Item No.", "Location Code", Open);
            ItemLedgEntry.SetRange("Item No.", SubOrderCompListVend."Item No.");
            ItemLedgEntry.SetRange("Location Code", SubOrderCompListVend."Vendor Location");
            //ItemLedgEntry.SETRANGE("Bin Code",SubOrderCompListVend."Vendor Bin Code");
            ItemLedgEntry.SetRange(Open, true);
            ItemLedgEntry.SetRange(Positive, true);
            ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."entry type"::Transfer);
            ItemLedgEntry.SetRange(Correction, false);
            if ItemLedgEntry.Find('-') then
                repeat
                    ItemLedgEntryBuff.Init;
                    ItemLedgEntryBuff.TransferFields(ItemLedgEntry);
                    ItemLedgEntryBuff."Subcon Order No." := SubOrderCompListVend."Document No.";
                    ItemLedgEntryBuff."Subcon Order Line No." := SubOrderCompListVend."Document Line No.";
                    ItemLedgEntryBuff."Line No." := SubOrderCompListVend."Line No.";
                    ItemLedgEntryBuff."Qty. per Unit of Measure" := SubOrderCompListVend."Qty. per Unit of Measure";
                    ItemLedgEntryBuff.Insert;
                until ItemLedgEntry.Next = 0;
            Commit;
            ItemLedgerEntries.LookupMode(true);
            ItemLedgerEntries.SetTableview(ItemLedgEntryBuff);
            if ItemLedgerEntries.RunModal = Action::LookupOK then;
        end;
    end;

    procedure ShowItemEntry()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemLedgerEntries: Page "Item Ledg. Entries";
        ItemLedgEntryBuff: Record "SSD Item Ledger Entry Buffer";
        PurchaseLine: Record "Purchase Line";
        ProdOrderComponent: Record "Prod. Order Component";
        SubOrderCompListVend: Record "Sub Order Comp. List Vend";
    begin
        SubOrderCompListVend.Reset;
        SubOrderCompListVend.SetRange("Document No.", Rec."Source No.");
        SubOrderCompListVend.SetRange("Document Line No.", Rec."Source Line No.");
        SubOrderCompListVend.SetRange("Parent Item No.", Rec."Item No.");
        if SubOrderCompListVend.FindFirst then begin
            ItemLedgEntryBuff.Reset;
            ItemLedgEntryBuff.SetCurrentkey("Subcon Order No.", "Subcon Order Line No.", "Line No.");
            ItemLedgEntryBuff.SetRange("Subcon Order No.", SubOrderCompListVend."Document No.");
            ItemLedgEntryBuff.SetRange("Subcon Order Line No.", SubOrderCompListVend."Document Line No.");
            ItemLedgEntryBuff.SetRange("Line No.", SubOrderCompListVend."Line No.");
            ItemLedgEntryBuff.SetRange(Apply, true);
            ItemLedgerEntries.LookupMode(true);
            ItemLedgerEntries.SetTableview(ItemLedgEntryBuff);
            if ItemLedgerEntries.RunModal = Action::LookupOK then;
        end;
    end;

    procedure ShowSubOrderDetailsForm()
    var
        PurchaseLine: Record "Purchase Line";
        SubOrderDetails: Page "Order Subcon. Details Delivery";
    begin
        PurchaseLine.Reset;
        PurchaseLine.SetRange("Document Type", PurchaseLine."document type"::Order);
        PurchaseLine.SetRange("No.", Rec."Item No.");
        PurchaseLine.SetRange("Document No.", Rec."Source No.");
        PurchaseLine.SetRange("Line No.", Rec."Source Line No.");
        SubOrderDetails.SetTableview(PurchaseLine);
        SubOrderDetails.RunModal;
    end;

}