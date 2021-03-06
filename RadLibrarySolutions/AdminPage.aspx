<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminPage.aspx.cs" Inherits="AdminPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        a {
            text-decoration: none;
        }
        .auto-style1 {
            font-size: large;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Image ID="Image1" runat="server" Height="178px" ImageUrl="~\Images\our_logo.PNG" Width="240px" />
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Homepage.aspx">Home Page</asp:HyperLink>
            &nbsp;&nbsp;&nbsp;
            <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/AdminPage.aspx" Font-Underline="True">Administrators</asp:HyperLink>
             &nbsp;&nbsp;&nbsp;
            <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/SearchPage.aspx" Font-Underline="False">Search Page</asp:HyperLink>
            <br />
            <span class="auto-style1"><strong>Number of books currently checked out by each user by their UserID:</strong></span><br />
        </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="Num_Books_Checked_Out" HeaderText="Num_Books_Checked_Out" ReadOnly="True" SortExpression="Num_Books_Checked_Out" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <SortedAscendingCellStyle BackColor="#FDF5AC" />
            <SortedAscendingHeaderStyle BackColor="#4D0000" />
            <SortedDescendingCellStyle BackColor="#FCF6C0" />
            <SortedDescendingHeaderStyle BackColor="#820000" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Checkout.UserID, [USER].Email, COUNT(CHECKOUT.CopyID) AS Num_Books_Checked_Out
FROM CHECKOUT, [USER]
WHERE Checkout.ReturnDate IS NULL
	AND CHECKOUT.UserID=[USER].UserID
GROUP BY Checkout.UserID, [USER].Email;"></asp:SqlDataSource>
        <span class="auto-style1"><strong><br />
        </strong>
        <br />
        <strong>List of Users and their current fines.<br />
        </strong>
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="Query4_GridView" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="FName" HeaderText="FName" SortExpression="FName" />
                <asp:BoundField DataField="Lname" HeaderText="Lname" SortExpression="Lname" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                <asp:BoundField DataField="Fine" HeaderText="Fine" ReadOnly="True" SortExpression="Fine" />
                <asp:BoundField DataField="PAID_STATUS" HeaderText="PAID_STATUS" SortExpression="PAID_STATUS" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <SortedAscendingCellStyle BackColor="#FDF5AC" />
            <SortedAscendingHeaderStyle BackColor="#4D0000" />
            <SortedDescendingCellStyle BackColor="#FCF6C0" />
            <SortedDescendingHeaderStyle BackColor="#820000" />
        </asp:GridView>
        <asp:SqlDataSource ID="Query4_GridView" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [USER].FName, [USER].Lname, [USER].Email, (OVERDUE_BOOK.Days_Overdue * 0.10 + 2) AS Fine, OVERDUE_BOOK.PAID_STATUS
FROM [USER]
FULL JOIN OVERDUE_BOOK
ON [USER].UserID = OVERDUE_BOOK.UserID
WHERE OVERDUE_BOOK.Paid_Status = 'NOT PAID';
"></asp:SqlDataSource>
        </span>
        <br />
        <br />
    </form>
</body>
</html>