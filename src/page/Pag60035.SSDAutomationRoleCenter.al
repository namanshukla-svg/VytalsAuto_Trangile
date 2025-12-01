page 60035 "SSD Automation Role Center"
{
    ApplicationArea = All;
    Caption = 'Automation Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("SSD Automation Activities"; "SSD Automation Activities")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(embedding)
        {
            action(WhseShpt)
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse Shipments';
                RunObject = Page "Warehouse Shipment List";
                ToolTip = 'View the list of ongoing warehouse shipments.';
            }
            action(WhseShptReleased)
            {
                ApplicationArea = Warehouse;
                Caption = 'Released Warehouse Shipments';
                RunObject = Page "Warehouse Shipment List";
                RunPageView = sorting("No.")where(Status=filter(Released));
                ToolTip = 'View the list of released source documents that are ready for warehouse activities.';
            }
            action(WhseRcpt)
            {
                ApplicationArea = Warehouse;
                Caption = 'Warehouse Receipts';
                RunObject = Page "Warehouse Receipts";
                ToolTip = 'View the list of ongoing warehouse receipts.';
            }
            action(WhseRcptReleased)
            {
                ApplicationArea = Warehouse;
                Caption = 'Released Warehouse Receipts';
                RunObject = Page "Warehouse Receipts";
                RunPageView = sorting("No.")where("SSD Status"=filter(Planned));
                ToolTip = 'View the list of ongoing warehouse receipts.';
            }
            action(TransferOrders)
            {
                ApplicationArea = Warehouse;
                Caption = 'Transfer Orders';
                Image = Document;
                RunObject = Page "Transfer Orders";
                ToolTip = 'Move inventory items between company locations. With transfer orders, you ship the outbound transfer from one location and receive the inbound transfer at the other location. This allows you to manage the involved warehouse activities and provides more certainty that inventory quantities are updated correctly.';
            }
        }
    }
}
