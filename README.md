# Inventory App - Accessing KeyVault secrets using Azure SDK

For the **Azure SDK** solution you'll need to add the Spring cloud dependency to your build.gradle/pom.xml file

    dependencies {  
	  implementation 'com.azure.spring:spring-cloud-azure-starter-keyvault:5.14.0'  
	}

Then, you'll need to define the KeyVault endpoint in the application.yml/application.properties file.

    application.yml 

	spring:
      cloud:
	   azure:
        keyvault.secret.endpoint=https://<your-keyvault-name>.vault.azure.net/

You'll have two different options to get the SecretClient bean that will let you access the secrets of the KeyVault:

1. Let Spring Boot auto-configuration create a ServiceClient bean using the default Azure credential to access the vault secrets.
2. Create your bean, pass the KeyVault endpoint, and define the credentials to access the vault.


      @Configuration  
      public  class SecretClientConfiguration { 
   
            @Bean  
            public SecretClient createSecretClient() { 
                return new SecretClientBuilder() 
                    .vaultUrl("https://<your-key-vault-url>.vault.azure.net/") 
                    .credential(new DefaultAzureCredentialBuilder().build()) 
                    .buildClient(); 
            } 
      }

Finally, you can access the secrets injecting the SecretClient bean into the class you will be requesting the secret value.

      public class ProductController {
   
          private final SecretClient secretClient;
      
          @GetMapping
          public ResponseEntity<String> getListProducts(){
              return ResponseEntity.ok(secretClient.getSecret("inventory-app-secret").getValue());
          }
      }
