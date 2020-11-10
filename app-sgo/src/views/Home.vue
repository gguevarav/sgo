<template>
  <section>
    <div>
      <v-row>
        <v-col
            md="6"
            cols="12"
            sm="12">
          <v-img
              src="@/assets/images/logo2.png">
          </v-img>
          <div>
            <h3>
              QUIENES SOMOS
            </h3>
            <p>
              "Somos una compañía guatemalteca, con 15 años de experiencia en el campo de la ingeniería,especializada en tratamiento y acondicionamiento de agua para la industria, enfocada primordialmente en la gestión y sostenibilidad de nuestros servicios."
            </p>
          </div>
        </v-col>
        <v-col
            md="6"
            cols="12"
            sm="12">
          <div>
            <br>
            <br>
            <h2>
              BIENVENIDOS A TRASISA
            </h2>
            <br>
            <br>
            <h4>
              NUESTRA EXPERIENCIA
            </h4>
            <small>
              Asesorías
            </small>
            <v-progress-linear
                color="blue"
                rounded
                value="95%"
            ></v-progress-linear>
            <small>
              Sistemas de filtración
            </small>
            <v-progress-linear
                color="blue"
                rounded
                value="85%"
            ></v-progress-linear>
            <small>
              Sistemas de dosificación continua y sistematizada de químicos
            </small>
            <v-progress-linear
                color="blue"
                rounded
                value="75%"
            ></v-progress-linear>
            <small>
              Control automático de dosificación de químico
            </small>
            <v-progress-linear
                color="blue"
                rounded
                value="65%"
            ></v-progress-linear>
            <small>
              Sistemas y productos químicos antiincrustantes y desincrustantes de tuberías y equipos
            </small>
            <v-progress-linear
                color="blue"
                rounded
                value="65%"
            ></v-progress-linear>
            <br>
          </div>
        </v-col>
      </v-row>
      <v-row>
        <v-col
            md="6"
            cols="12"
            sm="12"
            justify>
          <h3>
            VISIÓN
          </h3>
          <small>
            Ser una empresa líder en mercado guatemalteco en el tratamiento de aguas industriales y productos químicos que nos acerquen al liderazgo centroamericano, ofreciendo nuestro servicio de alta calidad y generando satisfacción en nuestros clientes.
          </small>
        </v-col>
        <v-col
            md="6"
            cols="12"
            sm="12">
          <h3>
            MISIÓN
          </h3>
          <small>
            Trasisa es una empresa especializada en el tratamiento de aguas industriales la cual con un grupo de profesionales experimentados se preocupa por brindar servicios de asesoría de alta calidad aportando soluciones prácticas y funcionales que satisfacen las necesidades de nuestros clientes.
          </small>
        </v-col>
      </v-row>
      <v-row>
        <v-col
            md="6"
            cols="12"
            sm="12">
          <v-row>
            <v-col
                cols="6">
              <v-card
                  elevation="0">
                <v-text>
                  <v-icon>
                    mdi-human-male-male
                  </v-icon>
                  <h3>
                    ASESORIAS
                  </h3>
                  <small>
                    Asesorías en tratamiento y acondicionamiento de agua para la industria
                  </small>
                </v-text>
              </v-card>
            </v-col>
            <v-col
                cols="6">
              <v-card
                  elevation="0">
                <v-text>
                  <v-icon>
                    mdi-check
                  </v-icon>
                  <h3>
                    NOS ESPECIALIZAMOS EN
                  </h3>
                  <small>
                    Sistemas de filtración de agua, lodos, aguas residuales, entre otros.
                  </small>
                </v-text>
              </v-card>
            </v-col>
          </v-row>
        </v-col>
        <v-col
            md="6"
            cols="12"
            sm="12">
          <v-row>
            <v-col
                md="6"
                cols="6"
                sm="6">
              <v-card
                  elevation="0">
                <v-text>
                  <v-icon>
                    mdi-water
                  </v-icon>
                  <h3>
                    SERVICIOS DE INGENIERÍA
                  </h3>
                  <small>
                    Sistemas de producción de agua por filtración con Ósmosis inversa.
                  </small>
                </v-text>
              </v-card>
            </v-col>
            <v-col
                md="6"
                cols="6"
                sm="6">
              <v-card
                  elevation="0">
                <v-text>
                  <v-icon>
                    mdi-flask-outline
                  </v-icon>
                  <h3>
                    NUESTROS PRODUCTOS QUÍMICOS
                  </h3>
                  <small>
                    Torres de enfriamiento
                  </small>
                </v-text>
              </v-card>
            </v-col>
          </v-row>
        </v-col>
      </v-row>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Home',
}
</script>