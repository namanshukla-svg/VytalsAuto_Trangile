codeunit 60016 "SSD Sync Warehouse Shipments"
{
    Permissions = tabledata "Item Ledger Entry"=rm;

    trigger OnRun()
    begin
        ItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.", "Package No.");
        ItemLedgerEntry.SetRange("Location Code", SSDCommonFunctionAutomation.GetAutomationLocationFilter());
        ItemLedgerEntry.SetRange("SSD Entry Synced", false);
        ItemLedgerEntry.SetRange(Positive, false);
        ItemLedgerEntry.SetFilter("Package No.", '<>%1', '');
        ItemLedgerEntry.SetFilter("Entry Type", '%1|%2|%3', ItemLedgerEntry."Entry Type"::Purchase, ItemLedgerEntry."Entry Type"::Sale, ItemLedgerEntry."Entry Type"::Transfer);
        if ItemLedgerEntry.FindSet()then repeat if SSDProcessWarehouseShipment.Run(ItemLedgerEntry)then begin
                    ItemLedgerEntry.SetLoadFields("Entry No.", "SSD Entry Synced");
                    ItemLedgerEntry2.Get(ItemLedgerEntry."Entry No.");
                    ItemLedgerEntry2."SSD Entry Synced":=true;
                    ItemLedgerEntry.Modify();
                end;
            until ItemLedgerEntry.Next() = 0;
    end;
    var ItemLedgerEntry: Record "Item Ledger Entry";
    ItemLedgerEntry2: Record "Item Ledger Entry";
    SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
    SSDProcessWarehouseShipment: Codeunit "SSD Process Warehouse Shipment";
}
