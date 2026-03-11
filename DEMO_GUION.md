# 🎬 Guión Demo en Vivo — Terraform Multi-Entorno + TFE

> **Duración estimada:** 8-12 minutos  
> **Objetivo:** Mostrar el flujo completo desde un cambio en GitHub hasta el recurso creado en Azure

---

## ✅ Checklist ANTES de la presentación

Haz esto el día anterior y repítelo 30 minutos antes:

- [ ] Repo subido a GitHub y visible en el navegador
- [ ] Workspace `ws-demo-dev` creado en TFE y conectado al repo
- [ ] Variables configuradas en TFE (`subscription_id`, `ARM_*`)
- [ ] Un **apply inicial ya ejecutado** → los recursos base ya existen en Azure
- [ ] Azure Portal abierto en el Resource Group `rg-workshopdemo-dev`
- [ ] TFE abierto en el workspace `ws-demo-dev`
- [ ] Rama `feature/demo-cambio` creada pero SIN push todavía
- [ ] Terminal abierta en el repo local
- [ ] Navegador con 3 pestañas: GitHub | TFE | Azure Portal

---

## 🎬 Guión paso a paso

---

### PARTE 1 — El repositorio (2 min)

**Qué enseñas:** GitHub, estructura de carpetas

**Dices:**
> "Aquí está nuestro repositorio. Fijáos en la estructura — un único código base,
> módulos reutilizables, y en la carpeta `environments` solo cambian los valores."

**Haces:**
1. Abre GitHub → muestra el árbol de carpetas
2. Abre `locals.tf` → señala la naming convention:
   ```
   resource_group_name = "rg-${var.project}-${var.environment}"
   ```
   > "El nombre del recurso se construye automáticamente. No hay que tocarlo por entorno."
3. Abre `environments/dev/terraform.tfvars` y luego `environments/pre/terraform.tfvars`
   > "¿Veis la diferencia? Solo cambia el valor de `environment`. El código es idéntico."

---

### PARTE 2 — Workspace en TFE (2 min)

**Qué enseñas:** TFE conectado a GitHub, variables sensibles

**Dices:**
> "Este workspace en TFE está conectado a nuestro repositorio de GitHub.
> Cuando hay un cambio, TFE lo detecta automáticamente."

**Haces:**
1. Abre TFE → workspace `ws-demo-dev`
2. Ve a **Settings → Version Control** → muestra el repo y rama conectados
3. Ve a **Variables** → muestra `subscription_id` marcada como sensible (valor oculto)
   > "Las credenciales nunca están en el repo. Viven aquí, en TFE, cifradas."
4. Muestra el historial de runs anteriores (el apply inicial)
   > "Cada ejecución queda registrada: quién lo aprobó, cuándo, qué cambió."

---

### PARTE 3 — El flujo PR → Plan → Apply (4-5 min)

**Qué enseñas:** el flujo completo end-to-end ⭐ (parte más impactante)

**Dices:**
> "Ahora voy a hacer un cambio real. Voy a añadir un tag nuevo a la Storage Account."

**Haces:**

**Paso 1 — El cambio en código**
```bash
# En la terminal, ya estás en la rama feature/demo-cambio
git checkout feature/demo-cambio
```
Abre `locals.tf` y añade un tag:
```hcl
common_tags = {
  environment = var.environment
  project     = var.project
  managed_by  = "terraform"
  team        = "cloud-infrastructure"
  demo        = "workshop-2026"      # ← línea nueva
}
```
```bash
git add locals.tf
git commit -m "feat: add demo tag to all resources"
git push origin feature/demo-cambio
```

**Paso 2 — El PR en GitHub**
1. Ve a GitHub → aparece el banner "Compare & pull request"
2. Abre el PR
   > "En cuanto abro el PR, GitHub notifica a TFE via webhook."
3. Espera ~15 segundos → aparece el check de TFE en el PR
   > "TFE ya está ejecutando el plan. Sin que yo haga nada más."

**Paso 3 — El Plan en TFE**
1. Haz clic en el check → se abre TFE directamente en el run
2. Muestra el plan:
   ```
   ~ azurerm_storage_account.this
       tags.demo = "workshop-2026"   (nuevo)
   
   Plan: 0 to add, 1 to change, 0 to destroy.
   ```
   > "Esto es lo que va a cambiar. Solo el tag. Nada más. Lo podemos revisar
   > antes de aplicar — aquí está la clave del flujo."

**Paso 4 — El Approve y Apply**
1. Baja al botón **Confirm & Apply**
   > "En producción, este botón lo pulsaría otra persona del equipo, no quien hizo el cambio."
2. Pulsa Apply → muestra los logs en tiempo real
3. Espera el `Apply complete!`

---

### PARTE 4 — Verificación en Azure (1 min)

**Qué enseñas:** el resultado real en Azure

**Haces:**
1. Ve al Azure Portal → Resource Group `rg-workshopdemo-dev`
2. Abre la Storage Account → pestaña **Tags**
3. El tag `demo: workshop-2026` aparece ahí
   > "El cambio está en producción. Con revisión, con trazabilidad, sin tocar
   > el portal de Azure manualmente."

---

### CIERRE DE LA DEMO (30 seg)

**Dices:**
> "En resumen: un cambio en código → PR → plan automático → revisión → apply.
> Todo auditado, todo repetible, y sin credenciales en ningún sitio."
>
> "La diferencia con hacer esto a mano en el portal o ejecutando terraform
> desde tu máquina es enorme en términos de seguridad y trazabilidad."

---

## 🚨 Plan B si algo falla en vivo

| Problema | Solución |
|----------|----------|
| TFE tarda mucho en hacer el plan | Tenlo ya en marcha antes de empezar y muéstralo ya ejecutado |
| Error en el apply | Muestra el error — "esto también pasa, y así es como lo vemos" |
| Azure Portal lento | Tenlo ya abierto y refresca solo al final |
| Sin conexión a internet | Ten capturas de pantalla de cada paso en slides de respaldo |

---

## 💬 Preguntas frecuentes que puede hacer el público

**"¿Cómo se gestiona el estado si somos varios a la vez?"**
> TFE hace locking automático del estado. Si alguien está haciendo apply, nadie más puede hasta que termine.

**"¿Y si quiero destruir recursos?"**
> Hay que hacer `terraform destroy` desde TFE — también queda auditado y requiere confirmación.

**"¿Qué diferencia hay entre este workspace dev y el de pre?"**
> Apuntan al mismo repo y mismo código, pero cada uno tiene su `subscription_id` diferente y carga sus propios `tfvars`.

**"¿Se puede bloquear que alguien haga apply en prod sin aprobación?"**
> Sí, con los Sentinel policies de TFE puedes requerir aprobaciones adicionales para entornos de producción.
