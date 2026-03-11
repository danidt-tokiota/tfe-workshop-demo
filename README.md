# terraform-multientorno-demo

Repositorio de demo para el workshop de **Terraform Multi-Entorno + Terraform Enterprise**.

## Estructura del repositorio

```
terraform-multientorno-demo/
├── main.tf                        # Orquestación de módulos
├── variables.tf                   # Declaración de variables
├── locals.tf                      # Naming convention y tags comunes
├── outputs.tf                     # Outputs del root module
├── modules/
│   ├── resource_group/            # Módulo: Azure Resource Group
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── storage_account/           # Módulo: Azure Storage Account
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── dev/
    │   └── terraform.tfvars       # Valores para DEV
    └── pre/
        └── terraform.tfvars       # Valores para PRE
```

## Principios de diseño

- **El código NO cambia entre entornos** — solo cambian los `.tfvars`
- **Naming convention** centralizado en `locals.tf` → `rg-workshopdemo-dev`
- **Tags obligatorios** en todos los recursos via `local.common_tags`
- **Variables sensibles** (subscription_id) gestionadas en TFE, nunca en el repo

## Configuración en Terraform Enterprise

Cada entorno tiene su propio **workspace** en TFE:

| Workspace           | Branch  | tfvars path              |
|---------------------|---------|--------------------------|
| `ws-demo-dev`       | `main`  | `environments/dev/`      |
| `ws-demo-pre`       | `main`  | `environments/pre/`      |

### Variables a configurar en cada workspace (TFE)

| Variable           | Tipo      | Sensible |
|--------------------|-----------|----------|
| `subscription_id`  | Terraform | ✅ Sí    |
| `ARM_CLIENT_ID`    | Entorno   | ✅ Sí    |
| `ARM_CLIENT_SECRET`| Entorno   | ✅ Sí    |
| `ARM_TENANT_ID`    | Entorno   | ✅ Sí    |

## Flujo de despliegue (PR → Apply)

```
1. git checkout -b feature/mi-cambio
2. # Hacer cambios en el código
3. git push origin feature/mi-cambio
4. Abrir Pull Request en GitHub
        ↓
5. TFE detecta el PR via webhook
6. TFE ejecuta terraform plan automáticamente
7. El plan aparece como check en el PR de GitHub
        ↓
8. Revisión del plan por el equipo
9. Approve en TFE → terraform apply
        ↓
10. Recursos desplegados en Azure
```

## Recursos desplegados

- **Azure Resource Group** → `rg-workshopdemo-<env>`
- **Azure Storage Account** → `stworkshopdem<env>`
