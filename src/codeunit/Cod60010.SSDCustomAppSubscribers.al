codeunit 60010 "SSD Custom App Subscribers"
{
    [EventSubscriber(ObjectType::Page, Page::"Material Receipt Note", 'OnBeforeMaterialReceiptPost', '', false, false)]
    local procedure SSDOnBeforeMaterialReceiptPost(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        AutomatedLocationErr: Label 'Warehouse Receipt for Automated Location cannot be posted from Material Receipt Note';
    begin
        if WarehouseReceiptHeader."Location Code" <> '' then if SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptHeader."Location Code")then Error(AutomatedLocationErr);
    end;
    [EventSubscriber(ObjectType::Page, Page::"Material Receipt Note", 'OnBeforeCreateQualityOrder', '', false, false)]
    local procedure SSDOnBeforeCreateQualityOrder(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; IsHandled: Boolean)
    begin
        if WarehouseReceiptHeader."Location Code" <> '' then if SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptHeader."Location Code")then IsHandled:=true;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SSD Warehouse Subscribers", 'OnWarehouseReceiptLineQtyUpdate', '', false, false)]
    local procedure SSDOnWarehouseReceiptLineQtyUpdate(var WhseReceiptLine: Record "Warehouse Receipt Line"; PurchaseLine: Record "Purchase Line"; var ExtensionIsHandled: Boolean)
    begin
        if WhseReceiptLine."Location Code" = '' then exit;
        if SSDCommonFunctionAutomation.IsLocationAutomated(WhseReceiptLine."Location Code")then ExtensionIsHandled:=true;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Quality Order -Post Line", 'OnBeforeReceiptUpdate', '', false, false)]
    local procedure SSDOnBeforeReceiptUpdate(SSDQualityOrderHeader: Record "SSD Quality Order Header"; var IsHandled: Boolean)
    var
        SSDQualityManagement: Codeunit "SSD Quality Management";
    begin
        if SSDQualityOrderHeader."Location Code" = '' then exit;
        if SSDCommonFunctionAutomation.IsLocationAutomated(SSDQualityOrderHeader."Location Code")then begin
            SSDQualityManagement.InsertQualityStatusFromQualityOrder(SSDQualityOrderHeader);
            IsHandled:=true;
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Sales Despatch Order", 'OnAfterGetSalesHeaderOnDispatchSlip', '', false, false)]
    local procedure SSDOnAfterGetSalesHeaderOnDispatchSlip(SalesHeader: Record "Sales Header")
    var
        AutomatedLocationErr: Label 'You cannot use Automated Location for Dispatch order';
    begin
        if SalesHeader."Location Code" = '' then exit;
        if SSDCommonFunctionAutomation.IsLocationAutomated(SalesHeader."Location Code")then Error(AutomatedLocationErr);
    end;
    [EventSubscriber(ObjectType::Page, Page::"Sales Desp. Order Subform", 'OnBeforeInsertDispatchLine', '', false, false)]
    local procedure SSDOnBeforeInsertDispatchLine(FromSalesLine: Record "Sales Line")
    var
        AutomatedLocationErr: Label 'You cannot use Automated Location for Dispatch order';
    begin
        if FromSalesLine."Location Code" = '' then exit;
        if SSDCommonFunctionAutomation.IsLocationAutomated(FromSalesLine."Location Code")then Error(AutomatedLocationErr);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Warehouse Mgt.", OnAfterCreateShptLineFromSalesLine, '', false, false)]
    local procedure OnAfterCreateShptLineFromSalesLine(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        if Customer.get(SalesLine."Sell-to Customer No.")then WarehouseShipmentHeader."Shipping Agent Code":=Customer."Shipping Agent Code 1";
    end;
    var SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
}
