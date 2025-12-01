page 60078 "SSD Dock Role Center"
{
    ApplicationArea = All;
    Caption = 'Dock Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("SSD Dock Activities"; "SSD Dock Activities")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(embedding)
        {
            action(WhseShptReleased)
            {
                ApplicationArea = Warehouse;
                Caption = 'Released Warehouse Shipments';
                RunObject = Page "Warehouse Shipment List";
                RunPageView = sorting("No.")where(Status=filter(Released));
                ToolTip = 'View the list of released source documents that are ready for warehouse activities.';
            }
            action(WhseRcptReleased)
            {
                ApplicationArea = Warehouse;
                Caption = 'Released Warehouse Receipts';
                RunObject = Page "Warehouse Receipts";
                RunPageView = sorting("No.")where("SSD Status"=filter(Planned));
                ToolTip = 'View the list of ongoing warehouse receipts.';
            }
        }
    }
}
