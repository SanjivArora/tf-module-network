output "id" {
  value = {for s in azurerm_subnet.subnet : s.name => s.id}
}
