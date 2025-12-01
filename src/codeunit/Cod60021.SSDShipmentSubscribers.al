codeunit 60021 "SSD Shipment Subscribers"
{
    Permissions = tabledata "Sales Invoice Line"=rm,
        tabledata "Sales Invoice Header"=rm;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnBeforeRun', '', false, false)]
    local procedure SSDShipmentOnBeforeRun(var WarehouseShipmentLine: Record "Warehouse Shipment Line"; var SuppressCommit: Boolean; PreviewMode: Boolean)
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
    begin
        if SuppressCommit or PreviewMode then exit;
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseShipmentLine."Location Code")then exit;
        if WarehouseShipmentHeader.Get(WarehouseShipmentLine."No.")then;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Whse. Post Shipment", 'OnInitSourceDocumentHeaderOnBeforeSalesHeaderModify', '', false, false)]
    local procedure SSDOnInitSourceDocumentHeaderOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header"; var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; var ModifyHeader: Boolean; WhsePostParameters: Record "Whse. Post Parameters"; var WarehouseShipmentLine: Record "Warehouse Shipment Line")
    begin
        if(WarehouseShipmentHeader."SSD Transport Method" <> '') and (WarehouseShipmentHeader."SSD Transport Method" <> SalesHeader."Transport Method")then begin
            SalesHeader."Transport Method":=WarehouseShipmentHeader."SSD Transport Method";
            ModifyHeader:=true;
        end;
        if(WarehouseShipmentHeader."SSD Vehicle No." <> '') and (WarehouseShipmentHeader."SSD Vehicle No." <> SalesHeader."Vehicle No.")then begin
            SalesHeader."Vehicle No.":=WarehouseShipmentHeader."SSD Vehicle No.";
            ModifyHeader:=true;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Selection Management", 'OnBeforeGetShipInvoiceSelectionForWhseActivity', '', false, false)]
    local procedure OnBeforeGetShipInvoiceSelectionForWhseActivity(DefaultOption: Integer; var Selection: Integer; var IsHandled: Boolean; var Result: Boolean)
    var
        ConfirmManagement: Codeunit "Confirm Management";
        ShipInvoiceConfirmQst: Label 'Do you want to post the shipment and invoice?';
    begin
        if not ConfirmManagement.GetResponseOrDefault(ShipInvoiceConfirmQst, true)then begin
            Result:=false;
            Selection:=2;
            IsHandled:=true;
        end
        else
        begin
            Selection:=2;
            IsHandled:=true;
            Result:=true;
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnBeforeDeleteUpdateWhseShptLine', '', false, false)]
    local procedure SSDOnBeforeDeleteUpdateWhseShptLine(WhseShptLine: Record "Warehouse Shipment Line"; var DeleteWhseShptLine: Boolean; var WhseShptLineBuf: Record "Warehouse Shipment Line")
    begin
        DeleteWhseShptLine:=true;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure SSDOnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        if SalesInvLine."System-Created Entry" then exit;
        if SalesInvLine.Quantity = 0 then IsHandled:=true;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure SSDOnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header")
    begin
        SalesInvHeader."Order/Scd. No.":=SalesInvHeader."Order No.";
    end;
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnAfterInitFromSalesLine', '', false, false)]
    local procedure SSDOnAfterInitFromSalesLine2(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line")
    begin
        if SalesLine."Location Code" = '' then exit;
        if SalesLine.Type <> SalesLine.Type::Item then exit;
        if not SSDCommonFunctionAutomation.IsLocationAutomated(SalesLine."Location Code")then exit;
        SalesInvLine."Gross Wt":=round(SalesInvLine.Quantity * SalesInvLine."Gross Weight", 0.001, '=');
        SalesInvLine."Actual Wt":=round(SalesInvLine.Quantity * SalesInvLine."Net Weight", 0.001, '=');
    end;
    procedure UpdateSalesInvoiceLineWeight()
    var
        Location: Record Location;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        Location.SetRange("SSD Automated Plant", true);
        if Location.FindFirst()then begin
            SalesInvoiceLine.SetRange("Location Code", Location.Code);
            SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
            SalesInvoiceLine.SetFilter("No.", '<>%1', '');
            if SalesInvoiceLine.FindSet()then repeat SalesInvoiceLine."Gross Wt":=round(SalesInvoiceLine.Quantity * SalesInvoiceLine."Gross Weight", 0.001, '=');
                    SalesInvoiceLine."Actual Wt":=round(SalesInvoiceLine.Quantity * SalesInvoiceLine."Net Weight", 0.001, '=');
                    SalesInvoiceLine.Modify();
                until SalesInvoiceLine.Next() = 0;
            SalesInvoiceHeader.SetRange("Location Code", Location.Code);
            if SalesInvoiceHeader.FindSet()then repeat SalesInvoiceHeader."Order/Scd. No.":=SalesInvoiceHeader."Order No.";
                    SalesInvoiceHeader.Modify();
                until SalesInvoiceHeader.Next() = 0;
        end;
    end;
    var SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
}
