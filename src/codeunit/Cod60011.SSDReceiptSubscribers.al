codeunit 60011 "SSD Receipt Subscribers"
{
    //Sync Receipt to Anzo
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnBeforeRun', '', false, false)]
    local procedure SSDOnBeforeRun(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; var SuppressCommit: Boolean; PreviewMode: Boolean)
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
    begin
        if SuppressCommit or PreviewMode then exit;
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptLine."Location Code") then exit;
        if WarehouseReceiptHeader.Get(WarehouseReceiptLine."No.") then SSDReservationManagement.SyncWarehouseReceipt(WarehouseReceiptHeader);
        Commit();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnBeforePostSourceDocument', '', false, false)]
    local procedure SSDOnBeforePostSourceDocument(var WhseRcptLine: Record "Warehouse Receipt Line"; PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header"; TransferHeader: Record "Transfer Header"; var CounterSourceDocOK: Integer; HideValidationDialog: Boolean; var IsHandled: Boolean)
    var
        Item: Record Item;
        SSDQualityManagement: Codeunit "SSD Quality Management";
        OrderCount: Integer;
        RecSourceType: Option Purchase,Manufacturing,,Calibration;
        TemplateType: Option Receipt,Manufacturing,,Calibration;
    begin
        if WhseRcptLine."Qty. to Receive" <= 0 then exit;
        if WhseRcptLine."Item No." = '' then exit;
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WhseRcptLine."Location Code") then exit;
        Item.Get(WhseRcptLine."Item No.");
        if not Item."Quality Required" then exit;
        if (WhseRcptLine."Source Type" <> Database::"Purchase Line") and (WhseRcptLine."Source Type" <> Database::"Sales Line") then exit;
        SSDQualityManagement.CreateReceiptQualityOrder(RecSourceType::Purchase, WhseRcptLine, TemplateType::Receipt, OrderCount);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnBeforePostSourceDocument', '', false, false)]
    local procedure SSDOnBeforePostSourceDocument2(var WhseRcptLine: Record "Warehouse Receipt Line"; PurchaseHeader: Record "Purchase Header"; SalesHeader: Record "Sales Header"; TransferHeader: Record "Transfer Header"; var CounterSourceDocOK: Integer; HideValidationDialog: Boolean; var IsHandled: Boolean)
    var
        Item: Record Item;
        SSDQualityManagement: Codeunit "SSD Quality Management";
    begin
        if WhseRcptLine."Qty. to Receive" <= 0 then exit;
        if WhseRcptLine."Item No." = '' then exit;
        Item.Get(WhseRcptLine."Item No.");
        if Item."Quality Required" then exit;
        if not SSDCommonFunctionAutomation.ItemPackageTracked(Item."No.") then exit;
        SSDQualityManagement.InsertQualityStatusForNonQualityItem(WhseRcptLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnAfterPostedWhseRcptLineInsert', '', false, false)]
    local procedure SSDOnAfterPostedWhseRcptLineInsert(var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        SSDQualityOrderHeader: Record "SSD Quality Order Header";
        SSDQualityOrderHeader2: Record "SSD Quality Order Header";
    begin
        SSDQualityOrderHeader.Reset();
        SSDQualityOrderHeader.SetCurrentKey("Lot No.", "Source Document No.", "Source Doc. Line No.");
        SSDQualityOrderHeader.SetRange("Source Document No.", WarehouseReceiptLine."No.");
        SSDQualityOrderHeader.SetRange("Source Doc. Line No.", WarehouseReceiptLine."Line No.");
        if SSDQualityOrderHeader.FindSet() then
            repeat
                SSDQualityOrderHeader2.Get(SSDQualityOrderHeader."No.");
                SSDQualityOrderHeader2."Source Document No." := PostedWhseReceiptLine."No.";
                SSDQualityOrderHeader2."Source Doc. Line No." := PostedWhseReceiptLine."Line No.";
                SSDQualityOrderHeader2.Modify();
            until SSDQualityOrderHeader.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchases Warehouse Mgt.", 'OnBeforePurchLine2ReceiptLine', '', false, false)]
    local procedure SSDOnBeforePurchLine2ReceiptLine(WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; var Result: Boolean)
    var
        Item: Record Item;
        ItemTypeMismatchErr: Label 'Material Type should be %1 in Warehouse Receipt %2', Comment = '%1 Material Type, %2 Receipt No.';
    begin
        //  if WarehouseReceiptHeader."SSD Material Type" = WarehouseReceiptHeader."SSD Material Type"::" " then exit;
        if (PurchaseLine.Type <> PurchaseLine.Type::Item) or (PurchaseLine."No." = '') then exit;
        Item.Get(PurchaseLine."No.");
        // if Item."SSD Item SubType" <> WarehouseReceiptHeader."SSD Material Type" then
        //     Error(ItemTypeMismatchErr, Item."SSD Item SubType", WarehouseReceiptHeader."No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Receipt Line", 'OnBeforeConfirmDelete', '', false, false)]
    local procedure SSDOnBeforeConfirmDelete(var WarehouseReceiptLine: Record "Warehouse Receipt Line"; var SkipConfirm: Boolean)
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
    begin
        WarehouseReceiptHeader.Reset();
        if WarehouseReceiptHeader.Get(WarehouseReceiptLine."No.") then WarehouseReceiptHeader.TestField("SSD Status", WarehouseReceiptHeader."SSD Status"::Open);
    end;

    var
        SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
        SSDReservationManagement: Codeunit "SSD Reservation Management";
}
