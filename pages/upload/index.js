import React, { useState, useRef } from "react";
import { BiCloud, BiPlus } from "react-icons/bi";
import { create } from "ipfs-http-client";

export default function Upload() {
  // Creating state for the input field

  const [category, setCategory] = useState("");
  const [location, setLocation] = useState("");
  const [thumbnail, setThumbnail] = useState("");

  //  Creating a ref for thumbnail and video
  const thumbnailRef = useRef();

  return (
    <div className="w-full h-screen bg-[#1a1c1f] flex flex-row">
      <div className="flex-1 flex flex-col">
        <div className="mt-5 mr-10 flex  justify-end">
          <div className="flex items-center">
            <button className="bg-transparent  text-[#9CA3AF] py-2 px-6 border rounded-lg  border-gray-600  mr-6">
              Descartar
            </button>
            <button
              onClick={() => {
                handleSubmit();
              }}
              className="bg-green-500 hover:bg-green-700 text-white  py-2  rounded-lg flex px-4 justify-between flex-row items-center"
            >
              <BiCloud />
              <p className="ml-2">Subir</p>
            </button>
          </div>
        </div>
        <div className="flex flex-col m-10     mt-5  lg:flex-row">
          <div className="flex lg:w-3/4 flex-col ">

            <div className="flex flex-row mt-10 w-[90%]  justify-between">
              <div className="flex flex-col w-2/5    ">
                <label className="text-[#9CA3AF]  text-sm">Selecciona un departamento</label>
                <select
                  value={location}
                  onChange={(e) => setLocation(e.target.value)}
                  className="w-[90%] text-white placeholder:text-gray-600  rounded-md mt-2 h-12 p-2 border  bg-[#1a1c1f] border-[#444752] focus:outline-none"
                >
                  <option>Bolívar</option>
                  <option>Boyacá</option>
                  <option>Caldas</option>
                  <option>Caquetá</option>
                  <option>Casanare</option>
                  <option>Cauca</option>
                  <option>Cesar</option>
                  <option>Chocó</option>
                  <option>Córdoba</option>
                  <option>Cundinamarca</option>
                  <option>Guainía</option>
                  <option>Guaviare</option>
                  <option>Huila</option>
                  <option>La Guajira</option>
                  <option>Magdalena</option>
                  <option>Meta</option>
                  <option>Nariño</option>
                  <option>Norte de Santander</option>
                  <option>Putumayo</option>
                  <option>Quindio</option>
                  <option>Risalda</option>
                  <option>San Andrés y Providencia</option>
                  <option>Santander</option>
                  <option>Sucre</option>
                  <option>Tolima</option>
                  <option>Valle del Cauca</option>
                  <option>Vaupés</option>
                  <option>Vichada</option>
                </select>
              </div>
              <div className="flex flex-col w-2/5    ">
                <label className="text-[#9CA3AF]  text-sm">Elige un tipo de licencia</label>
                <select
                  value={category}
                  onChange={(e) => setCategory(e.target.value)}
                  className="w-[90%] text-white placeholder:text-gray-600  rounded-md mt-2 h-12 p-2 border  bg-[#1a1c1f] border-[#444752] focus:outline-none"
                >
                  <option>Fabricación de derivados de cannabis</option>
                  <option>Fabricación de derivados NO psicoactivos de cannabis</option>
                  <option>Semillas para siembra y grano</option>
                  <option>Cultivo de plantas de cannabis psicoactivo</option>
                  <option>Cultivo de plantas de cannabis NO psicoactivo</option>
                </select>
              </div>
            </div>
            <label className="text-[#9CA3AF]  mt-10 text-sm">Sube foto de tu cédula de ciudadania</label>

            <div
              onClick={() => {
                thumbnailRef.current.click();
              }}
              className="border-2 w-64 border-gray-600  border-dashed rounded-md mt-2 p-2  h-36 items-center justify-center flex"
            >
              {thumbnail ? (
                <img
                  onClick={() => {
                    thumbnailRef.current.click();
                  }}
                  src={URL.createObjectURL(thumbnail)}
                  alt="thumbnail"
                  className="h-full rounded-md"
                />
              ) : (
                <BiPlus size={40} color="gray" />
              )}
            </div>

            <input
              type="file"
              className="hidden"
              ref={thumbnailRef}
              onChange={(e) => {
                setThumbnail(e.target.files[0]);
              }}
            />
          </div>
          </div>
          </div>         
    </div>
  );
}
