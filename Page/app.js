//llenar regiones
const regiones = document.getElementById('region');
const form = document.getElementById('form_votacion');

fetch('http://localhost:8080/regiones.php',{
  method:'GET',
  headers:{'Content-Type': 'application/json'}
  })
  .then((response)=>{
    return response.json()
  })
  .then((data)=>{
    for (var i= 0; i<data.length; i++){
      var option = document.createElement('option');
      option.value = i+1;
      option.text = data[i];
      option.id = i+1;
      regiones.appendChild(option);
    }
  })
  .catch(error => {
    console.log(error);
  })
  //Llenar candidatos
  fetch('http://localhost:8080/candidatos.php',{
    method:'GET',
    headers:{'Content-Type': 'application/json'}
    })
    .then((response)=>{
      return response.json()
    })
    .then((data)=>{
      var candidatos = document.getElementById('candidato');
      for (var i= 0; i<data.length; i++){
        var option = document.createElement('option');
        option.value = i+1;
        option.text = data[i];
        candidatos.appendChild(option);
      }
    })
    .catch(error => {
      console.log(error);
    })

//actualizar comunas
regiones.addEventListener('change', function(e){
  e.preventDefault();
  fetch(`http://localhost:8080/comunas.php?id=${e.target.value}`,{
    method:'GET',
    headers:{'Content-Type': 'application/json'}
    })
    .then((response)=>{
      return response.json()
    })
    .then((data)=>{
      var comunas = document.getElementById('comuna');
      while(comunas.firstChild){
        comunas.removeChild(comunas.firstChild);
      }
      for (var i= 0; i<data.length; i++){
        var option = document.createElement('option');
        option.value = i+1;
        option.text = data[i];
        comunas.appendChild(option);
        comunas.disabled = false;
      }
    })
    .catch(error => {
      console.log(error);
    })  
})

//mandar formulario
form.addEventListener('submit', function(e){
    e.preventDefault();
    //validar checkbox
    var metodologias = document.querySelectorAll('input[name="divulgacion[]"]:checked');
    if(metodologias.length<2){
      alert('Debe seleccionar al menos 2 formas en las que se entero de nosotros');
      return;
    }
    //validar rut
    var rut = document.getElementById('rut');
    if(!checkRUN(rut.value)){
      alert('ingrese un rut valido, sin puntos ni guion');
      return;
    }
    unique_rut(rut.value);
    //envio del formulario
    var data = new FormData(form);
    fetch('save_form.php',{
        method: 'POST',
        body: data,
    })
    .then((response)=>{
      return response.json()
    })
    .then((data)=>{
      alert(data);
      form.reset();
    })
})

//funcion validar rut
function checkRUN(run) {
  const isNumber = /^\d+$/;
  const { numRUN, dv } = cleanAndSplitRUN(run);
  if (!(numRUN && dv && isNumber.test(numRUN))) return false;

  let calculation = 0,
      series = 2,
      validDV = '';

  for (let i = numRUN.length - 1; i >= 0; i--) {
    if (series > 7) series = 2;
    calculation += (series * numRUN.charAt(i));
    series++;
  }

  calculation = 11 - (calculation % 11);

  if (calculation === 10) {
    validDV = 'K';
  } else if (calculation === 11) {
    validDV = '0';
  } else {
    validDV = calculation.toString();
  }
  return dv === validDV;
}
function cleanAndSplitRUN(run) {
  let cleanRUN = run?.replace(/[.-]/g, ''),
      numRUN = '',
      dv = '';

  if (cleanRUN?.length === 1) {
    numRUN = cleanRUN;
  } else if (cleanRUN?.length > 1) {
    numRUN = cleanRUN.slice(0, -1);
    dv = cleanRUN.slice(-1).toUpperCase();
  }

  return { numRUN, dv };
}
//validar rut unico
 async function unique_rut (run){
  const res = await  fetch(`http://localhost:8080/check_unique_rut.php?rut=${run}`,{
    method:'GET',
    headers:{'Content-Type': 'application/json'}
  })
  const data = await res.json(); 
  if(data[0]){
    alert('No puedes votar dos veces');
    return;
  }
  return true;
}
