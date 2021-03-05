using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using crudClientes.Models;

namespace crudClientes.Controllers
{
    public class PERSONASController : Controller
    {
        private Entities db = new Entities();

        // GET: PERSONAS
        public async Task<ActionResult> Index()
        {
            return View(await db.PERSONAS.ToListAsync());
        }

        // GET: PERSONAS/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PERSONAS pERSONAS = await db.PERSONAS.FindAsync(id);
            if (pERSONAS == null)
            {
                return HttpNotFound();
            }
            return View(pERSONAS);
        }

        // GET: PERSONAS/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: PERSONAS/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "PERSONA_ID,TIPO_IDENTIFICACION,IDENTIFICACION,PRIMER_NOMBRE,SEGUNDO_NOMBRE,PRIMER_APELLIDO,SEGUNDO_APELLIDO,NUMERO_CELULAR,DIRECCION,EMAIL")] PERSONAS pERSONAS)
        {
            if (ModelState.IsValid)
            {
                db.PERSONAS.Add(pERSONAS);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(pERSONAS);
        }

        // GET: PERSONAS/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PERSONAS pERSONAS = await db.PERSONAS.FindAsync(id);
            if (pERSONAS == null)
            {
                return HttpNotFound();
            }
            return View(pERSONAS);
        }

        // POST: PERSONAS/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "PERSONA_ID,TIPO_IDENTIFICACION,IDENTIFICACION,PRIMER_NOMBRE,SEGUNDO_NOMBRE,PRIMER_APELLIDO,SEGUNDO_APELLIDO,NUMERO_CELULAR,DIRECCION,EMAIL")] PERSONAS pERSONAS)
        {
            if (ModelState.IsValid)
            {
                db.Entry(pERSONAS).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(pERSONAS);
        }

        // GET: PERSONAS/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PERSONAS pERSONAS = await db.PERSONAS.FindAsync(id);
            if (pERSONAS == null)
            {
                return HttpNotFound();
            }
            return View(pERSONAS);
        }

        // POST: PERSONAS/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            PERSONAS pERSONAS = await db.PERSONAS.FindAsync(id);
            db.PERSONAS.Remove(pERSONAS);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
