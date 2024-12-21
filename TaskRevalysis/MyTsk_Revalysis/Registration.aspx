<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="TaskRevalysis.MyTsk_Revalysis.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--BootStrp Liks--%>
    <title>EMP Details</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <%--Sweet Alerts Links--%>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.6.0/dist/sweetalert2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.6.0/dist/sweetalert2.all.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="card mt-5">
                <div class="card card-head" style="background: #ADBBDA">
                    <h2 class="text-center mt-2 mb-3" style="color: #AC8968">Employee Details</h2>
                </div>
                <div class="card card-body" style="background: #EDE8F5">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-2 col-xl-2 col-xxl-2"></div>
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-4 col-xl-4 col-xxl-4">
                            <label><span style="color: red">*</span> Name:</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomlete="off"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="* Name is Required." ForeColor="Red" ControlToValidate="txtName" ValidationGroup="SR"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revName" runat="server" ErrorMessage="* Name must be at least 3 characters long and contain only letters and spaces." ForeColor="Red" ControlToValidate="txtName" ValidationGroup="SR" ValidationExpression="^[a-zA-Z\s]{3,}$"></asp:RegularExpressionValidator>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-4 col-xl-4 col-xxl-4">
                            <label><span style="color: red">*</span> Salary:</label>
                            <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" AutoCompleteType="Disabled" MaxLength="5" autocomlete="off"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSalary" runat="server" ErrorMessage="* Salary is Required." ForeColor="Red" ControlToValidate="txtSalary" ValidationGroup="SR"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revSalary" runat="server" ErrorMessage="* Salary must be a valid number." ForeColor="Red" ControlToValidate="txtSalary" ValidationGroup="SR" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-2 col-xl-2 col-xxl-2"></div>
                    </div>
                    <div class="row mt-0">
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-2 col-xl-2 col-xxl-2"></div>
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-4 col-xl-4 col-xxl-4">
                            <label><span style="color: red">*</span> DepartMent:</label>
                            <asp:DropDownList ID="DpDepartMent" runat="server" CssClass="form-control">
                                <asp:ListItem Value="0">--Select Department--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvDepartment" runat="server" ErrorMessage="* Department is Required." ForeColor="Red" InitialValue="0" ControlToValidate="DpDepartMent" ValidationGroup="SR"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-4 col-xl-4 col-xxl-4">
                            <label><span style="color: red">*</span> Age:</label>
                            <asp:TextBox ID="txtAge" runat="server" CssClass="form-control" AutoCompleteType="Disabled" autocomlete="off"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAge" runat="server" ErrorMessage="* Age is Required." ForeColor="Red" ControlToValidate="txtSalary" ValidationGroup="SR"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revAge" runat="server" ErrorMessage="* Age must be a number greater than 20." ForeColor="Red" ControlToValidate="txtAge" ValidationGroup="SR" ValidationExpression="^(2[1-9]|[3-9][0-9])$"></asp:RegularExpressionValidator>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-10 col-lg-2 col-xl-2 col-xxl-2"></div>
                    </div>
                    <div class="mt-3 text-center">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" ValidationGroup="SR" OnClick="btnSubmit_Click" />
                    </div>
                </div>
            </div>

            <div class="container mt-3">
                <div class="row justify-content-center mt-3">
                    <div class="grid-container">
                        <asp:GridView ID="gvEmployees" runat="server" CssClass="table table-striped table-bordered text-center" AutoGenerateColumns="False" OnRowEditing="gvEmployees_RowEditing" OnRowCancelingEdit="gvEmployees_RowCancelingEdit"
                            OnRowUpdating="gvEmployees_RowUpdating" OnRowDeleting="gvEmployees_RowDeleting" OnRowDataBound="gvEmployees_RowDataBound" DataKeyNames="EmpId">
                            <Columns>
                                <asp:TemplateField HeaderText="Employee Id">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmpid" runat="server" Text='<%# Bind("Empid") %>' ReadOnly="true"></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmpidEdit" runat="server" Text='<%# Bind("Empid") %>' ReadOnly="true" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employee Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmpName" runat="server" Text='<%# Bind("Name") %>' ReadOnly="true"></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEmpNameEdit" runat="server" Text='<%# Bind("Name") %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employee Salary">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSalary" runat="server" Text='<%# Bind("Salary") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtSalaryEdit" runat="server" Text='<%# Bind("Salary") %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartment" runat="server" Text='<%# Bind("Department") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DdlDepartmentEdit" runat="server"></asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employee Age">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtAgeEdit" runat="server" Text='<%# Bind("Age") %>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="EmployeeCode" HeaderText="EmployeeCode" SortExpression="EmployeeCode" ReadOnly="true" />
                                <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" HeaderText="Actions" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
