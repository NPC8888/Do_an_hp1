using Models;
using QLChuyenXeVaDatVe.BLL;
using System.IO;
using System;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using xediep.Models;
using BLL;
using System.Linq;
using xediep.webControl;

namespace QLChuyenXeVaDatVe
{
    public partial class QuanLyBaoCao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                gvBaoCao.DataSource = BaoCaoBLL.Instance.GetALLBaoCao();
                gvBaoCao.DataBind();
            }
        }
        protected void btnTim_Click(object sender, EventArgs e)
        {
            string key = txtTim.Text;
            if (key != null && key != "")
            {
                var baocaos = BaoCaoBLL.Instance.GetALLBaoCao();
                var list = baocaos.Where(x => BoLoc.TimKiem(x, txtTim.Text)).ToList();
                gvBaoCao.DataSource = list;
                gvBaoCao.DataBind();

            }
            else
            {
                gvBaoCao.DataSource = BaoCaoBLL.Instance.GetALLBaoCao();
                gvBaoCao.DataBind();
            }


        }
        public void inbaocao(object sender, EventArgs e)
        {

            int index = gvBaoCao.SelectedIndex;
            string mabaocao = gvBaoCao.DataKeys[index].Values["MaBaoCao"].ToString();
            int id = int.Parse(mabaocao);
            foreach (var bc in BaoCaoBLL.Instance.GetALLBaoCao())
            {
                if (bc.MaBaoCao == id)
                {
                    xuatfile(bc);
                    gvBaoCao.DataSource = BaoCaoBLL.Instance.GetALLBaoCao();
                    gvBaoCao.DataBind();
                }
            }

        }
        protected void xuatfile(BaoCao bc)
        {
            // Tạo tên file và đường dẫn trên server
            string filePath = Path.Combine(Path.GetTempPath(), "BaoCao.docx");


            // Tạo tài liệu Word mới
            using (WordprocessingDocument wordDoc = WordprocessingDocument.Create(filePath, WordprocessingDocumentType.Document))
            {
                // Tạo phần chính của tài liệu (MainDocumentPart)
                MainDocumentPart mainPart = wordDoc.AddMainDocumentPart();
                mainPart.Document = new Document();
                Body body = mainPart.Document.AppendChild(new Body());

                // ======== 1. Tiêu đề báo cáo ========
                Paragraph titlePara = new Paragraph();
                Run titleRun = new Run();
                titleRun.AppendChild(new Text("BÁO CÁO")); // Thêm nội dung tiêu đề
                titlePara.AppendChild(titleRun);

                // Căn giữa tiêu đề
                titlePara.ParagraphProperties = new ParagraphProperties(
                    new Justification() { Val = JustificationValues.Center }
                );

                body.AppendChild(titlePara); // Thêm tiêu đề vào tài liệu

                // ======== 2. Nội dung báo cáo ========
      
                string maBaoCao = bc.MaBaoCao.ToString();
                string loaiBaoCao = bc.LoaiBaoCao;
                string ngayBatDau = bc.NgayBatDau.ToString("yyyy-MM-dd");
                string ngayKetThuc = bc.NgayKetThuc.ToString("yyyy-MM-dd");
                int tongSoVe = bc.TongSoVe;
                decimal tongSoTien = bc.TongDoanhThu;

                // Tạo đoạn văn bản chứa dữ liệu báo cáo
                Paragraph contentPara = new Paragraph();
                Run contentRun = new Run();
                contentRun.AppendChild(new Text($"Mã báo cáo: {maBaoCao}"));
                contentRun.AppendChild(new Break());//break để xuống dòng

                contentRun.AppendChild(new Text($"Loại báo cáo: {loaiBaoCao}"));
                contentRun.AppendChild(new Break());

                contentRun.AppendChild(new Text($"Ngày bắt đầu: {ngayBatDau}"));
                contentRun.AppendChild(new Break());

                contentRun.AppendChild(new Text($"Ngày kết thúc: {ngayKetThuc}"));
                contentRun.AppendChild(new Break());

                contentRun.AppendChild(new Text($"Tổng số vé: {tongSoVe}"));
                contentRun.AppendChild(new Break());

                contentRun.AppendChild(new Text($"Tổng số tiền: {tongSoTien:#,##0} VND"));


                contentPara.AppendChild(contentRun);
                body.AppendChild(contentPara); // Thêm nội dung vào tài liệu

                // Lưu tài liệu
                mainPart.Document.Save();
            }

            // ======== 3. Gửi file Word về client ========
            Response.ContentType = "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            Response.AppendHeader("Content-Disposition", "attachment; filename=BaoCao.docx");
            Response.TransmitFile(filePath);
            Response.Flush();

            // Xóa file sau khi tải
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }

            Response.End();
        }
    }
}