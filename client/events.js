exports('DataViewNativeGetEventData', (eventGroup, index, argStructSize) => {
    const buffer = new ArrayBuffer(256);
    const view   = new DataView(buffer);

    Citizen.invokeNative("0x57EC5FA4D4D6AFCA", eventGroup, index, view, argStructSize, Citizen.returnResultAnyway());
    let out = new Int32Array(buffer);
    return out;
});