codeunit 60008 "SSD Auttomation Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnPostUpdateWhseDocumentsOnBeforeGetLocation', '', false, false)]
    local procedure SSDOnPostUpdateWhseDocumentsOnBeforeGetLocation(var WhseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptHeader2: Record "Warehouse Receipt Header";
    begin
        if WarehouseReceiptHeader2.Get(WhseReceiptHeader."No.")then begin
            WhseReceiptHeader."SSD Status":=WhseReceiptHeader."SSD Status"::Open;
            WhseReceiptHeader.Modify();
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnBeforePostUpdateWhseDocuments', '', false, false)]
    local procedure SSD(var WhseRcptHeader: Record "Warehouse Receipt Header")
    var
        PostedDocLbl: Label 'Posted Warehouse Receipt %1 has been created', Comment = '%1 = Posted Warehouse Receipt No.';
    begin
        if WhseRcptHeader."Create Posted Header" then if WhseRcptHeader."Receiving No." <> '' then Message(PostedDocLbl, WhseRcptHeader."Receiving No.");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Over-Receipt Mgt.", 'OnIsOverReceiptAllowed', '', false, false)]
    local procedure SSDOnIsOverReceiptAllowed(var OverReceiptAllowed: Boolean)
    begin
        OverReceiptAllowed:=false;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Purch. Release", 'OnBeforeCreateWhseRequest', '', false, false)]
    local procedure SSDPurchOnBeforeCreateWhseRequest(var WhseRqst: Record "Warehouse Request"; var PurchHeader: Record "Purchase Header")
    begin
        WhseRqst."SSD Destination Name":=PurchHeader."Buy-from Vendor Name";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Sales Release", 'OnBeforeCreateWhseRequest', '', false, false)]
    local procedure SSDSalesOnBeforeCreateWhseRequest(var WhseRqst: Record "Warehouse Request"; var SalesHeader: Record "Sales Header")
    begin
        WhseRqst."SSD Destination Name":=SalesHeader."Sell-to Customer Name";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Transfer Release", 'OnBeforeCreateWhseRequest', '', false, false)]
    local procedure SSDTransferOnBeforeCreateWhseRequest(var WarehouseRequest: Record "Warehouse Request"; TransferHeader: Record "Transfer Header")
    begin
        if WarehouseRequest.Type <> WarehouseRequest.Type::Inbound then exit;
        WarehouseRequest."SSD Destination Name":=TransferHeader."Transfer-to Name";
    end;
    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnAfterProcessDocumentLine', '', false, false)]
    local procedure SSDOnAfterProcessDocumentLine(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var WarehouseRequest: Record "Warehouse Request"; var LineCreated: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; OneHeaderCreated: Boolean; WhseHeaderCreated: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
    begin
        if WarehouseRequest.Type <> WarehouseRequest.Type::Inbound then exit;
        if WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Sales Return Order" then if SalesHeader.Get(SalesHeader."Document Type"::"Return Order", WarehouseRequest."Source No.")then begin
                WarehouseReceiptHeader."SSD Source Name":=SalesHeader."Sell-to Customer Name";
                WarehouseReceiptHeader.Modify();
            end;
        if WarehouseRequest."Source Document" = WarehouseRequest."Source Document"::"Purchase Order" then if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, WarehouseRequest."Source No.")then begin
                WarehouseReceiptHeader."SSD Source Name":=PurchaseHeader."Buy-from Vendor Name";
                WarehouseReceiptHeader.Modify();
            end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Shipment Release", 'OnBeforeReopen', '', false, false)]
    local procedure SSDOnBeforeReopen(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var IsHandled: Boolean)
    var
        WarehouseShipmentHeader2: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        CombinedShipmentErr: Label 'Shipment is combined with other shipments. Remove link before reopening';
        ShipmentSyncErr: Label 'Shipment is already synced for Pick Wave. You cannot reopen';
    begin
        WarehouseShipmentHeader2.SetRange("SSD Combined With", WarehouseShipmentHeader."No.");
        if not WarehouseShipmentHeader2.IsEmpty then Error(CombinedShipmentErr);
        WarehouseShipmentLine.Reset();
        WarehouseShipmentLine.SetRange("No.", WarehouseShipmentHeader."No.");
        WarehouseShipmentLine.SetRange("Pick Planned", true);
        if not WarehouseShipmentLine.IsEmpty then Error(ShipmentSyncErr);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeDeleteAfterPosting', '', false, false)]
    local procedure SSDOnBeforeDeleteAfterPosting(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SkipDelete: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    var
        SSDAutomationSetup: Record "SSD Automation Setup";
        WarehouseRequest: Record "Warehouse Request";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then exit;
        SSDAutomationSetup.Get();
        if SSDAutomationSetup."Block SO Deletion" then begin
            SkipDelete:=true;
            WarehouseRequest.DeleteRequest(DATABASE::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.");
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Component", 'OnValidateItemNoOnAfterUpdateUOMFromItem', '', false, false)]
    local procedure SSDOnValidateItemNoOnAfterUpdateUOMFromItem(var ProdOrderComponent: Record "Prod. Order Component"; xProdOrderComponent: Record "Prod. Order Component"; Item: Record Item)
    begin
        if not ProdOrderComponent."SSD WMS Request Sent" then ProdOrderComponent."SSD Consumption Station":=Item."SSD Consumption Station";
    end;
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnValidateItemTrackingCodeOnBeforeTestNoEntriesExist', '', false, false)]
    local procedure SSDOnValidateItemTrackingCodeOnBeforeTestNoEntriesExist(Item: Record Item)
    var
        ItemTrackingCode: Record "Item Tracking Code";
    begin
        if Item."Item Tracking Code" = '' then exit;
        ItemTrackingCode.Get(Item."Item Tracking Code");
        ItemTrackingCode.TestField("SSD Blocked", false);
    end;
}
