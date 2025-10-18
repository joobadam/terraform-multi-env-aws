# Terraform Multi-Environment AWS Infrastructure

Többkörnyezetes AWS infrastruktúra Terraform workspace-ekkel demonstrációs portfolio projekt.

## Architektúra

A projekt egy egyszerű, többkörnyezetes AWS infrastruktúrát hoz létre:

- **VPC**: Környezet-specifikus CIDR blokkokkal
- **Subnets**: 2 public subnet minden VPC-ben
- **Internet Gateway**: Internet hozzáférés
- **Route Tables**: Routing konfiguráció
- **Security Groups**: Környezet-specifikus biztonsági szabályok
- **IAM Role**: EC2 instance-ekhez (SSM access, S3 read-only)
- **EC2 Instances**: t2.micro instance-ek környezet-specifikus darabszámmal
- **S3 Bucket**: Környezet-specifikus névvel, titkosítással és verziózással

## Környezetek Különbségei

| Környezet | VPC CIDR | Instance Darab | SSH Hozzáférés | Security Group |
|-----------|----------|----------------|----------------|----------------|
| **dev**   | 10.0.0.0/16 | 1x t2.micro | Bárhonnan (0.0.0.0/0) | Engedékenyebb |
| **stage** | 10.1.0.0/16 | 1x t2.micro | Korlátozott IP-ről | Közepesen szigorú |
| **prod**  | 10.2.0.0/16 | 2x t2.micro | Csak VPN/bastion-ről | Szigorú |

## Előfeltételek

- AWS fiók aktív Free Tier-el
- Terraform >= 1.0 telepítve
- GitHub fiók
- AWS CLI konfigurálva (opcionális)

## Lokális Használat

### 1. Klónozás és beállítás

```bash
git clone <repository-url>
cd terraform-multi-env-aws
```

### 2. Terraform változók beállítása

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
# Szerkeszd a terraform.tfvars fájlt a saját értékeiddel
```

### 3. Terraform inicializálás

```bash
cd terraform
terraform init
```

### 4. Workspace kezelés

```bash
# Workspace-ek listázása
terraform workspace list

# Új workspace létrehozása
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod

# Workspace váltás
terraform workspace select dev
```

### 5. Infrastruktúra létrehozása

```bash
# Plan futtatása
terraform plan

# Apply futtatása
terraform apply
```

### 6. Output értékek megtekintése

```bash
terraform output
```

## GitHub Actions Használat

### 1. GitHub Secrets beállítása

A repository Settings > Secrets and variables > Actions menüben add hozzá:

- `AWS_ACCESS_KEY_ID`: AWS access key ID
- `AWS_SECRET_ACCESS_KEY`: AWS secret access key

### 2. Workflow futtatása

- **Automatikus**: Minden push a main ágra (terraform/** path-ok változásakor) futtatja a plan-t
- **Manuális**: Repository Actions menüben válaszd ki a "Terraform Deploy" workflow-t és futtasd a kívánt környezettel

## Költségek

Ez a projekt kizárólag AWS Free Tier resource-okat használ:

- **EC2**: t2.micro instance-ek (750 óra/hó ingyenes)
- **S3**: Standard storage (5GB ingyenes)
- **VPC**: Ingyenes
- **IAM**: Ingyenes
- **CloudWatch**: Alapvető monitoring ingyenes

A projekt teljesen ingyenesen futtatható Free Tier keretein belül.

## Cleanup

Infrastruktúra törlése:

```bash
cd terraform
terraform workspace select <environment>
terraform destroy
```

Minden környezet törléséhez ismételd meg a fenti lépéseket minden workspace-szel.

## Projekt Struktúra

```
terraform-multi-env-aws/
├── terraform/
│   ├── main.tf                    # Fő infrastruktúra
│   ├── variables.tf               # Változók
│   ├── outputs.tf                 # Kimeneti értékek
│   ├── backend.tf                 # State backend konfiguráció
│   └── terraform.tfvars.example   # Példa változó fájl
├── .github/workflows/
│   └── deploy.yml                 # GitHub Actions workflow
└── README.md                      # Dokumentáció
```

## License

MIT License - részletek a LICENSE fájlban.

## Hozzájárulás

Ez egy demonstrációs portfolio projekt. Feedback és javaslatok szívesen fogadottak!
