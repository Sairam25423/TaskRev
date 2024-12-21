using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using TaskRevalysis.App_Start;

namespace TaskRevalysis.MyTsk_Revalysis
{
    public partial class Registration : System.Web.UI.Page
    {
        DataAccessLayer objBL = new DataAccessLayer();
        #region PageLoad
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridData(); BindDepartments();
            }
        }
        #endregion
        #region BtnSubmit
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!(string.IsNullOrEmpty(txtName.Text.Trim()) && string.IsNullOrWhiteSpace(txtSalary.Text.Trim()) && string.IsNullOrEmpty(txtAge.Text.Trim())) && DpDepartMent.SelectedIndex > 0)
            {
                int Age = Convert.ToInt32(txtAge.Text);
                if (Age >= 20)
                {
                    string SP = "Sp_InsertData"; string[] ParameterNames = { "@Name", "@Salary", "@Age", "@Department", };
                    string[] ParameterValues = { txtName.Text.Trim(), txtSalary.Text.Trim(), txtAge.Text.Trim(), DpDepartMent.SelectedItem.Text };
                    bool Result = objBL.InsertData(SP, ParameterNames, ParameterValues);
                    if (Result == true)
                    {
                        string script = @"
                    Swal.fire({
                    title: 'Success!',
                    text: 'Details inserted successfully.',
                    icon: 'success',
                    confirmButtonText: 'OK'
                    });";
                        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                        txtName.Text = txtSalary.Text = txtAge.Text = txtSalary.Text = string.Empty; DpDepartMent.SelectedIndex = -1; BindGridData();
                    }
                    else
                    {
                        string script = @"
                Swal.fire({
                title: 'Failure!',
                text: 'Something went wrong.',
                icon: 'error',
                confirmButtonText: 'OK'
                });";
                        ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
                    }
                }
            }

        }
        #endregion
        #region BindData
        public void BindGridData()
        {
            string SP = "Sp_GetData"; string[] ParameterNames = null; string[] ParameterValues = null;
            DataSet Ds = objBL.RetrievedData(SP, ParameterNames, ParameterValues);
            if (Ds.Tables[0].Rows.Count > 0)
            {
                gvEmployees.DataSource = Ds.Tables[0];
                gvEmployees.DataBind();
                gvEmployees.Visible = true;
            }
        }
        #endregion
        #region RowEdit
        protected void gvEmployees_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvEmployees.EditIndex = e.NewEditIndex;
            BindGridData();
        }
        #endregion
        #region RowCancel
        protected void gvEmployees_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvEmployees.EditIndex = -1;
            BindGridData();
        }
        #endregion
        #region RowUpdate
        protected void gvEmployees_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvEmployees.Rows[e.RowIndex];
            string EmpId = (row.FindControl("txtEmpidEdit") as TextBox).Text;
            string EmpName = (row.FindControl("txtEmpNameEdit") as TextBox).Text.Trim();
            string EmpSalary = (row.FindControl("txtSalaryEdit") as TextBox).Text.Trim();
            string EmpAge = (row.FindControl("txtAgeEdit") as TextBox).Text.Trim();
            string EmpDepartment = ((DropDownList)row.FindControl("DdlDepartmentEdit")).SelectedItem.Text.ToString();
            if (!(string.IsNullOrEmpty(EmpName.Trim()) && string.IsNullOrEmpty(EmpSalary.Trim()) && string.IsNullOrEmpty(EmpAge.Trim()) && string.IsNullOrEmpty(EmpDepartment.Trim())))
            {
                string SP = "Sp_UpdateDetails"; string[] ParameterNames = { "@EmpId", "@Name", "@Salary", "@Department", "@Age" };
                string[] ParameterValues = { EmpId, EmpName, EmpSalary, EmpDepartment, EmpAge };
                bool Result = objBL.InsertData(SP, ParameterNames, ParameterValues);
                if (Result==true)
                {
                    gvEmployees.EditIndex = -1; BindGridData();
                }
            }
        }
        #endregion
        #region RowDelete
        protected void gvEmployees_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            string empId = gvEmployees.DataKeys[e.RowIndex].Value.ToString();
            string SP = "Sp_DeleteDetails"; string[] ParameterNames = { "@EmpId" };
            string[] ParameterValues = { empId };
            bool Result = objBL.InsertData(SP, ParameterNames, ParameterValues);
            if (Result == true)
            {
                gvEmployees.EditIndex = -1;
                BindGridData();
            }
            else
            {
                string script = @"
                Swal.fire({
                title: 'Failure!',
                text: 'Something went wrong.',
                icon: 'error',
                confirmButtonText: 'OK'
                });";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);
            }
        }
        #endregion
        #region BindDropDown
        public void BindDepartments()
        {
            string SP = "Sp_LoadDepartments"; string[] ParameterNames = null; string[] ParameterValues = null;
            DataSet Ds = objBL.RetrievedData(SP, ParameterNames, ParameterValues);
            if (Ds.Tables[0].Rows.Count > 0)
            {
                DpDepartMent.DataSource = Ds.Tables[0];
                DpDepartMent.DataTextField = "DepartmentName";
                DpDepartMent.DataValueField = "DepartmentId";
                DpDepartMent.DataBind();
                DpDepartMent.Items.Insert(0, new ListItem("---Select Department---", "0"));

            }
        }
        #endregion
        #region RowDataBound
        protected void gvEmployees_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("DdlDepartmentEdit");
                if (ddl != null)
                {
                    string SP = "Sp_LoadDepartments"; string[] ParameterNames = null; string[] ParameterValues = null;
                    DataSet Ds = objBL.RetrievedData(SP, ParameterNames, ParameterValues);
                    if (Ds.Tables[0].Rows.Count > 0)
                    {
                        ddl.DataSource = Ds.Tables[0];
                        ddl.DataTextField = "DepartmentName";
                        ddl.DataValueField = "DepartmentId";
                        ddl.Items.Insert(0, new ListItem("---Select Department---", "0"));
                        ddl.DataBind();

                        string currentDept = DataBinder.Eval(e.Row.DataItem, "Department").ToString();
                        ddl.SelectedValue = currentDept;
                    }
                }
            }
        }
        #endregion
    }
}