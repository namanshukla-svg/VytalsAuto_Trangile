codeunit 60009 "SSD Production Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", 'OnValidateNoOnAfterAssignItemFields', '', false, false)]
    local procedure SSDOnValidateNoOnAfterAssignItemFields(var ProductionBOMLine: Record "Production BOM Line"; Item: Record Item; var xProductionBOMLine: Record "Production BOM Line"; CallingFieldNo: Integer)
    begin
        //  Atul::01122025   ProductionBOMLine."SSD Consumption Station":=Item."SSD Consumption Station";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", 'OnAfterTransferBOMComponent', '', false, false)]
    local procedure SSDOnAfterTransferBOMComponent(var ProdOrderLine: Record "Prod. Order Line"; var ProductionBOMLine: Record "Production BOM Line"; var ProdOrderComponent: Record "Prod. Order Component"; LineQtyPerUOM: Decimal; ItemQtyPerUOM: Decimal)
    var
        Item: Record Item;
    begin
        if ProductionBOMLine.Type <> ProductionBOMLine.Type::Item then exit;
        //  Atul::01122025 
        // if ProductionBOMLine."SSD Consumption Station" <> ProductionBOMLine."SSD Consumption Station"::" " then ProdOrderComponent."SSD Consumption Station":=ProductionBOMLine."SSD Consumption Station"
        // else if Item.Get(ProdOrderComponent."Item No.")then ProdOrderComponent."SSD Consumption Station":=Item."SSD Consumption Station";
        //  Atul::01122025 
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", 'OnBeforeProdOrderCompModify', '', false, false)]
    local procedure SSDOnBeforeProdOrderCompModify(var ProdOrderComp: Record "Prod. Order Component"; var ProdBOMLine: Record "Production BOM Line"; LineQtyPerUOM: Decimal; ItemQtyPerUOM: Decimal)
    var
        Item: Record Item;
    begin
        if ProdBOMLine.Type <> ProdBOMLine.Type::Item then exit;
        if ProdBOMLine."SSD Consumption Station" <> ProdBOMLine."SSD Consumption Station"::" " then
            ProdOrderComp."SSD Consumption Station" := ProdBOMLine."SSD Consumption Station"
        //  Atul::01122025  else if Item.Get(ProdOrderComp."Item No.") then ProdOrderComp."SSD Consumption Station" := Item."SSD Consumption Station";

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnAfterChangeStatusOnProdOrder', '', false, false)]
    local procedure SSDOnAfterChangeStatusOnProdOrder(var ProdOrder: Record "Production Order"; var ToProdOrder: Record "Production Order"; NewStatus: Enum "Production Order Status"; NewPostingDate: Date; NewUpdateUnitCost: Boolean; var SuppressCommit: Boolean)
    var
        SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
        SSDSyncProduction: Codeunit "SSD Sync Production Actions";
    begin
        if NewStatus <> NewStatus::Finished then exit;
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ProdOrder."Location Code") then exit;
        SSDSyncProduction.SyncProductionOutput(ProdOrder);
    end;
}
